variable "project" {
  type        = string
  description = "Project Name"
  default     = "myprojectlocalmodule" #Lower case required #No special character required
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "sample"
}

variable "rds_db_password" {
    type = string
    description = "Root user password"
    default = "Passw0rd!123456"
}

variable "facebook_app_id" {
  type = string
  description = "Facebook App ID for Cognito Identity Pool"
  default = "1111111111111111"
}