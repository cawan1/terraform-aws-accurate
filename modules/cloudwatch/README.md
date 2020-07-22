
*Accurate Software*

# AWS CloudFront Terraform module

Accurate AWS CloudWatch.

Terraform module which creates a Dashboard in AWS using AWS Cloudwatch.

This module will create by default a CloudWatch Dashboard for a Cloudfront Distribution.

## Usage

     module  "cloudwatch" {    
        source = "./modules/cloudwatch"    
        project = var.project
        environment = var.environment
		distribution_id = var.distribution_id
        }

## Input
|  Name|Description   | Type | Default | Required
|--|--|--|--|--|
|  project| The name of the project for the repository | `string`| n/a | yes |
|  environment| The environment of the project  | `string`| n/a | yes |
|  distribution_id | CloudFront Distribution ID | `string` | n/a | yes |

## Outputs

|Name|Description  |
|--|--|
|dashboard_cdn_arn  | Dashboard CDN ARN |


## Examples
[Pantheon-Dev](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/src/tree/master/terraform/dev)