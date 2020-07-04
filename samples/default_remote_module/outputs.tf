output "vpc_id" {
 description = "The ID of the VPC"
 value       = module.accurate.vpc_id
}

output "public_subnets" {
 description = "List of IDs of public subnets"
 value       = module.accurate.public_subnets
}

output "database_subnets" {
 description = "List of IDs of database subnets"
 value       = module.accurate.database_subnets
}

output "rds_instance_endpoint" {
 description = "Endpoint Connection"
 value       = module.accurate.rds_instance_endpoint
}

output "rds_instance_name" {
 description = "The database name"
 value       = module.accurate.rds_instance_name
}

output "rds_instance_username" {
 description = "The master username for the database"
 value       = module.accurate.rds_instance_username
}

output "cdn_domainname" {
 value = module.accurate.cdn_domainname
 description = "CDN Domain name"
}

output "cognito_user_pool_id" {
    value = module.accurate.cognito_user_pool_id
}

output "cognito_user_pool_client_id" {
    value = module.accurate.cognito_user_pool_client_id
}

output "cognito_identity_pool_id" {
    value = module.accurate.cognito_identity_pool_id
}
