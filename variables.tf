variable "project" {
  type        = string
  description = "Project Name"
  default     = "cawan"
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "rds_db_password" {
   type = string
   description = "Root user password"
}

# variable "facebook_app_id" {
#   type = string
#   description = "Facebook App ID for Cognito Identity Pool"
# }
