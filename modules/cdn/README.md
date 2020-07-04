
*Accurate Software*

# AWS CloudFront Terraform module

Accurate AWS CloudFront and AWS S3 Terraform module.

Terraform module which creates a CDN in AWS using AWS Cloudfront + AWS S3.

This module will create by default a CloudFront Distribution and a S3 Bucket.

## Usage

     module  "cdn" {    
        source = "./modules/cdn"    
        project = "myproject"
        environment = "dev"
        }

## Input
|  Name|Description   | Type | Default | Required
|--|--|--|--|--|
|  project| The name of the project for the repository | `string`| n/a | yes |
|  environment| The environment of the project  | `string`| n/a | yes |
|  default_root_object | Default object in CDN | `string` |"index.html" | no |
|  allowed_methods | Allowed http methods in CDN | `list(string)` | ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"] | no |
|  cached_methods | Cached http methods in CDN | `list(string)` | ["GET", "HEAD"] | no |
|  price_class | Price Class | `string` |"PriceClass_All" | no |
|  default_ttl | Default time to live in seconds | `number` | 3600 | no |
|  default_ttl | Max time to live in seconds | `number` | 86400 | no |
|  cloudfront_default_certificate | If cdn will use the default aws certificate | `bool` | true | no |
|  restriction_type | The method that you want to use to restrict distribution of your content by country, | `string` |"none" | no |

## Outputs

|Name|Description  |
|--|--|
|cdn_domainname  | CDN Domain name  |

## Examples
[Pantheon-Dev](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/src/tree/master/terraform/dev)