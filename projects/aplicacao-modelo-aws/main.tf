provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

# Remote Backend
# https://www.terraform.io/docs/backends/types/remote.html
# For authenticating use Environment variables in your workspace.
# Environment variables
# https://www.terraform.io/docs/providers/aws/index.html#environment-variables
# WorkSpace Variables
# https://www.terraform.io/docs/cloud/workspaces/variables.html


terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "accurate" 
    workspaces {
      ## Creating Workspaces 
      # https://www.terraform.io/docs/cloud/workspaces/creating.html # Adding a new name create a default workspace(no variables).
      name = "aplicacao-modelo-aws"
    }
  }
}

module  "accurate" {    
  # Private Module Registry
  ## Publishing 
  # https://www.terraform.io/docs/cloud/registry/publish.html
  ## Using
  # https://www.terraform.io/docs/cloud/registry/using.html

   source = "app.terraform.io/accurate/appmodule/aws"    
   version = "1.0.0"    
   project = var.project  #lower case required # No special  character required
   environment = var.environment    
   rds_db_password = var.rds_db_password
   }
