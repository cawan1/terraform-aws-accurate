output "storage_uploads_arn" {
  description = "S3 Bucket ARN used for app uploads"
  value = module.storage.aws_s3_bucket_uploads_arn
}

output "storage_uploads_name" {
  description = "S3 Bucket Name used for app uploads"
  value = module.storage.aws_s3_bucket_uploads_name
}
