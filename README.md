
*Accurate Software*

# AWS Terraform module

APP Modelo AWS Terraform module.

Terraform module which creates by default resources on AWS.


## Usages
This module can be used in diffent ways.
1. [Root Module](#root-module)
  - Importing as a generic module which creates default resources for app-modelo-aws project using *default deployed sub modules* and requiring some [variables](#input).
    - You can change the default behavior changing ``*.tf`` files

2. [Importing Desired Modules](#importing-desired-child-modulesjust-local)
  - Importing sub modules as you want, *(ex.If you want to create only one resource or different groups of resources)*.

3. [Using Remote Backend](#remote-backend)
   - As [Root Module](#root-module) but using remote backend(*terraform.io*) instead of a local one.

- [Deployed Sub Modules](#deployed-sub-modules)

### Root Module

#### Using Local Backend

     module  "accurate" {    
        source = "../../"
        project = var.project  #lower case required # No special  character required
        environment = var.environment    
        rds_db_password = var.rds_db_password
        facebook_app_id = var.facebook_app_id
        }

#### Example
[Sample-Default-Local-Root-Module](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/terraform-aws-accurate/tree/master/samples/default)

### Importing desired Child Modules(Just Local Backend)

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
       facebook_app_id = var.facebook_app_id
     }
#### Example
[Sample-Default-Local-Desired-Child-Module](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/terraform-aws-accurate/tree/master/samples/default)


### Using Remote Backend
 module  "accurate" {    
    source = "app.terraform.io/accurate/accurate/aws"    
    version = "1.0.2"    
    project = "myproject"  #lower case required # No special  character required
    environment = "test"   
    rds_db_password = "mypassword123"
    facebook_app_id = var.facebook_app_id
    }

#### Example
[Sample-Default-Remote-Root-Module](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/terraform-aws-accurate/tree/master/samples/default)


### Deployed Sub Modules
Check which README for detailed configuration.
- set as default:
  - [CDN](./modules/cdn/README.md)
  - [Cognito](./modules/cognito/README.md)
  - [VPC](./modules/vpc/README.md)
  - [RDS](./modules/rds/README.md)
- deployed:
  - [ECR](./modules/ecr/README.md)



## Input
|  Name|Description   | Type | Default | Required
|--|--|--|--|--|
|  project| The name of the project for the repository lower case required | `string`| n/a | yes |
|  environment | The environment of the project | `string`| n/a | yes |
|  rds_db_password | Password for root user in RDS Postgres instance | `string`| n/a | yes |
|  facebook_app_id | Facebook App ID for Cognito Identity Pool | `string`| n/a | yes |

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