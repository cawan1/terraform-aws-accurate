*Accurate Software*

# AWS VPC Terraform module

Accurate AWS VPC Terraform module.

Terraform module which creates VPC resources on AWS.

This module will create by default a VPC with 3 subnets(public, private, database) in 2 regions (us-east-1a ,us-east-1b).

## Usage

     module  "vpc" {    
        source = "./modules/vpc"    
        project = "myproject"
        environment = "dev"
        }

## Input
|  Name|Description   | Type | Default | Required
|--|--|--|--|--|
|  project| The name of the project | `string`| n/a | yes |
|  environment| The environment of the project  | `string`| n/a | yes |
|  azs | 	A list of availability zones names or ids in the region | `list(string)`| ["us-east-1a", "us-east-1b"] | no |
|  cidr | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | `string`| "20.10.0.0/16" | no |
|  private_subnets | A list of private subnets inside the VPC | `list(string)`| ["20.10.1.0/24", "20.10.2.0/24"] | no |
|  public_subnets | A list of public subnets inside the VPC | `list(string)`| ["20.10.11.0/24", "20.10.12.0/24"] | no |
|  database_subnets | A list of database subnets inside the VPC | `list(string)`| ["20.10.21.0/24", "20.10.22.0/24"] | no |
## Outputs

|Name|Description  |
|--|--|
|vpc_id  | The ID of the VPC  |
|private_subnets  | List of IDs of private subnets  |
|public_subnets  | List of IDs of public subnets  |
|database_subnets  | List of IDs of database subnets  |


## Examples
[Pantheon-Dev](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/src/tree/master/terraform/dev)