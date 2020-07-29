module "vpc" {
    source = "./modules/vpc"
    project = var.project
    environment = var.environment
}


module "rds" {
    source = "./modules/rds"
    project = var.project
    environment = var.environment
    vpc_id = module.vpc.vpc_id
    db_password = var.rds_db_password 
}

module "scheduler" {
    source = "./modules/scheduler"
    project = var.project
    environment = var.environment
    mattermost_webhook = var.mattermost_webhook
    mattermost_channel = var.mattermost_channel
}


module "cdn" {
    source = "./modules/cdn"
    project = var.project
    environment = var.environment
    cname = var.cdn_cname
}

module "cognito" {
  source      = "./modules/cognito"
  project     = var.project
  environment = var.environment
  facebook_app_id = var.facebook_app_id
}


module "cloudwatch" {
    source = "./modules/cloudwatch"
    project = var.project
    environment = var.environment
    distribution_id = module.cdn.distribution_id
}


