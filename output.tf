output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}


output "rds_instance_endpoint" {
  description = "Endpoint Connection"
  value       = module.rds.rds_instance_endpoint
}

output "rds_instance_name" {
  description = "The database name"
  value       = module.rds.rds_instance_name
}

output "rds_instance_username" {
  description = "The master username for the database"
  value       = module.rds.rds_instance_username
}

output "scheduler_lambda_start" {
  description = "Lambda function trigged by cloudwatch to stop RDS Instance"
  value = module.scheduler.aws_lambda_function_start
}

output "scheduler_lambda_stop" {
  description = "Lambda function trigged by cloudwatch to start RDS Instance"
  value = module.scheduler.aws_lambda_function_stop
}

output "cdn_domainname" {
  description = "CDN Domain name"
  value       = module.cdn.cdn_domainname

}

output "distribution_id" {
  value = module.cdn.distribution_id
  description = "CDN Distribution ID"
}



output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value = module.cognito.cognito_user_pool_id
}

output "cognito_user_pool_client_id" {
  description = "Cognito User Pool Client ID"
  value = module.cognito.cognito_user_pool_client_id
}

output "cognito_identity_pool_id" {
  description = "Cognito Identity Pool ID"
  value = module.cognito.cognito_identity_pool_id
}

output "cognito_authenticated_role" {
  description = "Cognito Authenticated Role ARN"
  value = module.cognito.cognito_authenticated_role
}

output "storage_uploads_arn" {
  description = "S3 Bucket ARN for app uploads"
  value = module.storage.aws_s3_bucket_uploads_arn
}

output "storage_uploads_name" {
  description = "S3 Bucket Name for app uploads"
  value = module.storage.aws_s3_bucket_uploads_name
}