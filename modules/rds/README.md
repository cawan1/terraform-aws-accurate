
*Accurate Software*

# AWS RDS Terraform module

Accurate AWS RDS Terraform module.

Terraform module which creates RDS resources on AWS.

This module will create by default a RDS Database Postgres 9.6 free-tier configuration.

Required resource VPC with subnets.

## Usage

     module  "rds" {    
        source = "./modules/rds"    
        project = "myproject"
        environment = "dev"
        vpc_id = module.vpc.vpc_id
        db_password = "cawanzinhoboladao001112"
        }

## Input
|  Name|Description   | Type | Default | Required
|--|--|--|--|--|
|  project| The name of the project for the repository | `string`| n/a | yes |
|  environment| The environment of the project  | `string`| n/a | yes |
|  vpc_id | VPC ID which RDS will run | `string` | n/a | yes |
|  database_subnets | A list of database subnets inside the VPC | `list(string)`| ["20.10.21.0/24", "20.10.22.0/24"] | yes |
|  db_username | Root username for rds | `string`| "dbadmin" | no |
|  db_password | Password for root user user | `string`| n/a | yes |
|  db_instance_class | RDS instance type | `string`| n/a | no |
|  db_instance_port | Port of database instance | `string`| "5432" | no |
|  db_engine | The database engine to use | `string`| "postgres" | no |
|  db_engine_version |	The engine version to use | `string`| "9.6.9" | no |
|  db_storage_type | The database storage type | `string`| "gp2" | no |
|  db_allocated_storage | Size in GB for storage allocated for database | `number`| 5 | no |
|  db_family | The family of the DB parameter group | `string`| "postgres9.6" | no |
|  db_major_engine_version | 	Specifies the major version of the engine that this option group should be associated with | `string`| "9.6" | no |


## Outputs

|Name|Description  |
|--|--|
|rds_instance_endpoint  | Endpoint Connection |
|rds_instance_name  | The database name  |
|rds_instance_username  | The root username for the database  |


## Examples
[Pantheon-Dev](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/src/tree/master/terraform/dev)