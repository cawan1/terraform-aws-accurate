provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"

  # About Authentication 
  # https://www.terraform.io/docs/providers/aws/index.html#authentication

  # Environment variables
  # https://www.terraform.io/docs/providers/aws/index.html#environment-variables

  # Static credentials
  # https://www.terraform.io/docs/providers/aws/index.html#static-credentials
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"

  # Shared Credentials file
  # https://www.terraform.io/docs/providers/aws/index.html#shared-credentials-file
  #shared_credentials_file = "/Users/tf_user/.aws/creds"
  shared_credentials_file = "C:\\Users\\cawan\\.aws\\credentials"
  profile                 = "pantheon"
}

module "scheduler" {
    source = "../../modules/scheduler"
    project = var.project
    environment = var.environment
    mattermost_webhook = var.mattermost_webhook
    mattermost_channel = var.mattermost_channel
}