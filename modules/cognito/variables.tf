variable "project" {
  type = string
  description = "Project Name"
}
variable "environment" {
  type = string
  description = "environment"
}

variable "facebook_app_id" {
  type = string
  description = "Facebook App ID for Cognito Identity Pool"
}


variable "bucket_uploads_arn" {
  type = string
  description = "ARN of s3 bucket for app uploads"
}