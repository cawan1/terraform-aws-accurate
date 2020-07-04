
*Accurate Software*

# AWS Terraform module

APP Modelo AWS Terraform module.

Terraform module which creates resources on AWS.

This module by default will create:
- VPC
  - 2 subnets
- RDS
  - Free-tier Postgres - Public Accessible
- CDN
  - CloudFront Distribution
  - S3 Bucket
- Cognito
  - User Pool
  - User Pool Client
  - Identity Pool

## Usages
This module can be used in diffent ways.

### Root Module
#### Using Remote Backend

#### Using Local Backend
###

     module  "accurate" {    
        source = "app.terraform.io/accurate/ecr/aws"    
        version = "1.0.0"    
        project = "myproject"
        environment = "test"   
        rds_db_password = "mypassword123"
        }

### Importing desired Child Modules(Just Local)
###
     module "vpc" {
         source = "../../modules/vpc"
         project = var.project
         environment = var.environment
     }
     
     module "rds" {
         source = "../../modules/rds"
         project = var.project
         environment = var.environment
         vpc_id = module.vpc.vpc_id
         db_password = var.rds_db_password 
     }
     
     module "cdn" {
         source = "../../modules/cdn"
         project = var.project
         environment = var.environment
     }
     
     module "cognito" {
       source      = "../../modules/cognito"
       project     = var.project
       environment = var.environment
     }

## Input
|  Name|Description   | Type | Default | Required
|--|--|--|--|--|
|  project| The name of the project for the repository lower case required | `string`| n/a | yes |
|  environment | The environment of the project | `string`| n/a | yes |
|  rds_db_password | Password for root user in RDS Postgres instance | `string`| n/a | yes |

## Outputs

|Name|Description  |
|--|--|
|vpc_id  | The ID of the VPC  |
|public_subnets  | List of IDs of public subnets  |
|database_subnets  | List of IDs of database subnets  |
|rds_instance_endpoint  | Endpoint Connection  |
|rds_instance_name  | The database name  |
|rds_instance_username  | The master username for the database  |
|cognito_user_pool_id | Cognito User Pool ID |
|cognito_user_pool_client_id | Cognito User Pool Client ID |
|cognito_identity_pool_id | Cognito Identity Pool ID |



## Examples
  - [Pantheon-Dev](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/src/tree/master/terraform/dev)
  - [Sample-Default-Local-Desired-Child-Module](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/terraform-aws-accurate/tree/master/samples/default)
  - [Sample-Default-Local-Root-Module](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/terraform-aws-accurate/tree/master/samples/default)
  - [Sample-Default-Remote-Root-Module](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/terraform-aws-accurate/tree/master/samples/default)