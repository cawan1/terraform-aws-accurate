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

# module "cdn" {
#     source = "./modules/cdn"
#     project = var.project
#     environment = var.environment
# }

# module "cognito" {
#   source      = "./modules/cognito"
#   project     = var.project
#   environment = var.environment
#   facebook_app_id = var.facebook_app_id
# }