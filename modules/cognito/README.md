*Accurate Software*

# AWS Cognito Terraform module

Accurate AWS Cognito Terraform module.

Terraform module which creates a Cognito User Pool, User Pool Client and Identity Pool resources on AWS.

This module will create by default:
    - User Pool
      - Required attributes: name, email(used as username)
    - User Pool Client 
      - Amplify default configuration (GenerateSecret: false)
    - Identity Pool
      - User Pool as provider only
      - Allow invoke any api in current aws region


## Usage

     module  "cognito" {    
        source = "./modules/cognito"    
        project = "myproject"
        environment = "dev"
        }

## Input
|  Name|Description   | Type | Default | Required
|--|--|--|--|--|
|  project| The name of the project | `string`| n/a | yes |
|  environment| The environment of the project  | `string`| n/a | yes |

## Outputs

|Name|Description  |
|--|--|
|cognito_user_pool_id  | The ID of the User Pool  |
|cognito_user_pool_client_id  | The ID of the User Pool Client  |
|cognito_identity_pool_id  | The ID of the Identity Pool |


## Examples
[Pantheon-Dev](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/src/tree/master/terraform/dev)