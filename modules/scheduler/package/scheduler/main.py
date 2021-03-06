# -*- coding: utf-8 -*-

"""This script stop and start aws resources."""
import os

# from scheduler.cloudwatch_handler import CloudWatchAlarmScheduler
from scheduler.rds_handler import RdsScheduler


def lambda_handler(event, context):
    """Main function entrypoint for lambda.

    Stop and start AWS resources:
    - rds instances
    """
    _strategy = {}
    # Retrieve variables from aws lambda ENVIRONMENT
    schedule_action = os.getenv("SCHEDULE_ACTION")
    aws_regions = os.getenv("AWS_REGIONS").replace(" ", "").split(",")
    tag_key = os.getenv("TAG_KEY")
    tag_value = os.getenv("TAG_VALUE")
    _strategy[RdsScheduler] = os.getenv("RDS_SCHEDULE")
    # _strategy[CloudWatchAlarmScheduler] = os.getenv("CLOUDWATCH_ALARM_SCHEDULE")
    for service, to_schedule in _strategy.items():
        if to_schedule == "true":
            for aws_region in aws_regions:
                strategy = service(aws_region)
                getattr(strategy, schedule_action)(tag_key, tag_value)
