resource "aws_s3_bucket" "uploads" {
  bucket = "${var.project}-uploads-${var.environment}"
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  tags = {
    Name = "${var.project}-uploads-${var.environment}"
  }
}



