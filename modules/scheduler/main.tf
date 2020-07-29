# # Freeze aws provider version
# terraform {
#   required_version = ">= 0.12"

#   required_providers {
#     aws     = ">= 2.9.0"
#     archive = ">= 1.2.2"
#   }
# }

data "aws_region" "current" {}


locals {
  lambda_logging_policy = {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow"
        "Resource": "${aws_cloudwatch_log_group.this.arn}",
      }
    ]
  }

  lambda-scheduler-policy = {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "rds:ListTagsForResource",
          "rds:DescribeDBInstances",
          "rds:StartDBInstance",
          "rds:StopDBInstance"
        ],
        "Effect": "Allow"
        "Resource": "*"
      },
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }

    ]
  }

}

# Convert *.py to .zip because AWS Lambda need .zip
data "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/package/"
  output_path = "${path.module}/aws-stop-start-resources.zip"
}


################################################
#
#            IAM CONFIGURATION START
#
################################################

resource "aws_iam_role" "start" {
  count  = var.schedule_start == true ? 1 : 0
  name        = "${var.project}-scheduler-start-${var.environment}"
  description = "Allows Lambda functions to start rds resources"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "schedule_start_rds" {
  count  = var.schedule_start == true ? 1 : 0
  name  = "${var.project}-rds-start-policy-${var.environment}"
  role  = aws_iam_role.start[count.index].id
  policy = jsonencode(local.lambda-scheduler-policy)
}


resource "aws_iam_role_policy" "lambda_start_logging" {
  count  = var.schedule_start == true ? 1 : 0
  name   = "${var.project}-start-logging-${var.environment}"
  role   = aws_iam_role.start[count.index].id
  policy = jsonencode(local.lambda_logging_policy)
}


################################################
#
#            LAMBDA FUNCTION START
#
################################################

# Create Lambda function for stop or start aws resources
resource "aws_lambda_function" "start" {
  count  = var.schedule_start == true ? 1 : 0
  filename         = data.archive_file.this.output_path
  function_name    = "${var.project}-start-rds-${var.environment}"
  role             = aws_iam_role.start[count.index].arn
  handler          = "scheduler/main.lambda_handler"
  source_code_hash = data.archive_file.this.output_base64sha256
  runtime          = "python3.7"
  timeout          = "600"

  environment {
    variables = {
      AWS_REGIONS               = data.aws_region.current.name
      SCHEDULE_ACTION           = "start"
      TAG_KEY                   = "Name"
      TAG_VALUE                 = "${var.project}-postgres-${var.environment}"
      RDS_SCHEDULE              = "true"
      MATTERMOST_WEBHOOK        = var.mattermost_webhook
      MATTERMOST_CHANNEL        = var.mattermost_channel
      # CLOUDWATCH_ALARM_SCHEDULE = var.cloudwatch_alarm_schedule
    }
  }
}


################################################
#
#            CLOUDWATCH EVENT START
#
################################################


resource "aws_cloudwatch_event_rule" "start" {
  count  = var.schedule_start == true ? 1 : 0
  name                = "${var.project}-trigger-start-${var.environment}"
  description         = "Trigger lambda Start RDS scheduler"
  schedule_expression = var.cloudwatch_schedule_start_expression
}


resource "aws_cloudwatch_event_target" "start" {
  count  = var.schedule_start == true ? 1 : 0
  arn  = aws_lambda_function.start[count.index].arn
  rule = aws_cloudwatch_event_rule.start[count.index].name
}

resource "aws_lambda_permission" "start" {
  count  = var.schedule_start == true ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = aws_lambda_function.start[count.index].function_name
  source_arn    = aws_cloudwatch_event_rule.start[count.index].arn
}


################################################
#
#            IAM CONFIGURATION STOP
#
################################################

resource "aws_iam_role" "stop" {
  count  = var.schedule_stop == true ? 1 : 0
  name        = "${var.project}-scheduler-stop-${var.environment}"
  description = "Allows Lambda functions to stop rds resources"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


resource "aws_iam_role_policy" "schedule_stop_rds" {
  count  = var.schedule_stop == true ? 1 : 0
  name  = "${var.project}-rds-stop-policy-${var.environment}"
  role  = aws_iam_role.stop[count.index].id
  policy = jsonencode(local.lambda-scheduler-policy)
}



resource "aws_iam_role_policy" "lambda_stop_logging" {
  count  = var.schedule_stop == true ? 1 : 0
  name   = "${var.project}-stop-logging-${var.environment}"
  role   = aws_iam_role.stop[count.index].id
  policy = jsonencode(local.lambda_logging_policy)
}

################################################
#
#            LAMBDA FUNCTION STOP
#
################################################

# Create Lambda function for stop or start aws resources
resource "aws_lambda_function" "stop" {
  count  = var.schedule_stop == true ? 1 : 0
  filename         = data.archive_file.this.output_path
  function_name    = "${var.project}-stop-rds-${var.environment}"
  role             = aws_iam_role.stop[count.index].arn
  handler          = "scheduler/main.lambda_handler"
  source_code_hash = data.archive_file.this.output_base64sha256
  runtime          = "python3.7"
  timeout          = "600"
  # kms_key_arn      = var.kms_key_arn == null ? "" : var.kms_key_arn

  environment {
    variables = {
      AWS_REGIONS               = data.aws_region.current.name
      SCHEDULE_ACTION           = "stop"
      # TAG_KEY                   = var.resources_tag["key"]
      TAG_KEY                   = "Name"
      # TAG_VALUE                 = var.resources_tag["value"]
      TAG_VALUE                 = "${var.project}-postgres-${var.environment}"
      RDS_SCHEDULE              = "true"
      MATTERMOST_WEBHOOK        = var.mattermost_webhook
      MATTERMOST_CHANNEL        = var.mattermost_channel
      # CLOUDWATCH_ALARM_SCHEDULE = var.cloudwatch_alarm_schedule
    }
  }


  tags = {
    Name = "${var.project}-scheduler-${var.environment}"
  }
}

################################################
#
#            CLOUDWATCH EVENT STOP
#
################################################

resource "aws_cloudwatch_event_rule" "stop" {
  count  = var.schedule_stop == true ? 1 : 0
  name                = "${var.project}-trigger-stop-${var.environment}"
  description         = "Trigger lambda Stop RDS scheduler"
  schedule_expression = var.cloudwatch_schedule_stop_expression
}

resource "aws_cloudwatch_event_target" "stop" {
  count  = var.schedule_stop == true ? 1 : 0
  arn  = aws_lambda_function.stop[count.index].arn
  rule = aws_cloudwatch_event_rule.stop[count.index].name
}

resource "aws_lambda_permission" "stop" {
  count  = var.schedule_stop == true ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = aws_lambda_function.stop[count.index].function_name
  source_arn    = aws_cloudwatch_event_rule.stop[count.index].arn
}

################################################
#
#            CLOUDWATCH LOG GENERAL
#
################################################
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.project}/${var.environment}"
  retention_in_days = 14
}
