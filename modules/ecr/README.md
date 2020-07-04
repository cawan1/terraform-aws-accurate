
*Accurate Software*

# AWS ECR Terraform module

Accurate AWS ECR Terraform module.

Terraform module which creates ECR resources on AWS.

AWS ECR by default creates a repository for each image, just versioning image by tags.
We are using the name of the ECR repositories, such as "project/image:tag" for organizational purposes.

## Usage

     module  "ecr" {    
        source = "./modules/ecr"   
        project = "myproject"    
        images = ["myimage1","myimage2","myimage3"]    
        }

## Input
|  Name|Description   | Type | Default
|--|--|--|--|
|  project| The name of the project for the repository lower case required | `string`| n/a |
|  images| List of images names | `list(string)`| n/a |

## Outputs

|Name|Description  |
|--|--|
|repositories  | List of "repository name = repository url"  |


## Examples
[Pantheon-Dev](https://git.acclabs.com.br/gitlab/acc/aplicacao-modelo-aws/src/tree/master/terraform/dev)