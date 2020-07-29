# -*- coding: utf-8 -*-

### https://github.com/diodonfrost/terraform-aws-lambda-scheduler-stop-start

"""rds instances scheduler."""

from typing import Iterator

import boto3

import os

import botocore.vendored.requests as requests

from botocore.exceptions import ClientError

from .exceptions import rds_exception

class RdsScheduler(object):
    """Abstract rds scheduler in a class."""

    def __init__(self, region_name=None) -> None:
        """Initialize rds scheduler."""
        if region_name:
            self.rds = boto3.client("rds", region_name=region_name)
        else:
            self.rds = boto3.client("rds")

    def stop(self, tag_key: str, tag_value: str) -> None:
        """Aws rds cluster and instance stop function.

        Stop rds aurora clusters and rds db instances with defined tag.

        :param str tag_key:
            Aws tag key to use for filter resources
        :param str tag_value:
            Aws tag value to use for filter resources
        """

        for instance_id in self.list_instances(tag_key, tag_value):
            try:
                self.rds.stop_db_instance(DBInstanceIdentifier=instance_id)
                message = "Stoping rds instance {0}".format(instance_id)
                print(message)
                self.send_mattermost_message(message)
            except ClientError as exc:
                rds_exception("rds instance", instance_id, exc)

    def start(self, tag_key: str, tag_value: str) -> None:
        """Aws rds cluster start function.

        Start rds aurora clusters and db instances a with defined tag.

        :param str tag_key:
            Aws tag key to use for filter resources
        :param str tag_value:
            Aws tag value to use for filter resources
        """

        for instance_id in self.list_instances(tag_key, tag_value):
            try:
                self.rds.start_db_instance(DBInstanceIdentifier=instance_id)
                message = "Starting rds instance {0}".format(instance_id)
                print (message)
                self.send_mattermost_message(message)
            except ClientError as exc:
                rds_exception("rds instance", instance_id, exc)

    def send_mattermost_message(self, message: str):
        webhook_url = os.getenv("MATTERMOST_WEBHOOK") 
        channel = os.getenv("MATTERMOST_CHANNEL")
        message_json = {"text": message, "channel": channel} 
        r = requests.post(webhook_url, json=message_json)
        if r.status_code == 200:
            print ("Mattermost message sent.")

    def list_instances(self, tag_key: str, tag_value: str) -> Iterator[str]:
        """Aws rds instance list function.

        Return the list of all rds instances

        :param str tag_key:
            Aws tag key to use for filter resources
        :param str tag_value:
            Aws tag value to use for filter resources

        :yield Iterator[str]:
            The list Id of filtered rds instances
        """
        paginator = self.rds.get_paginator("describe_db_instances")

        for page in paginator.paginate():
            for instance in page["DBInstances"]:
                reponse_instance = self.rds.list_tags_for_resource(
                    ResourceName=instance["DBInstanceArn"]
                )
                taglist = reponse_instance["TagList"]

                # Retrieve rds instance with specific tag
                for tag in taglist:
                    if tag["Key"] == tag_key and tag["Value"] == tag_value:
                        yield instance["DBInstanceIdentifier"]