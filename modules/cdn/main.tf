##########################
###   CDN CloudFront    ##
##########################

resource "aws_s3_bucket" "origin" {
  bucket = "${var.project}-origin-${var.environment}"
  acl    = "private"
  tags = {
    Name = "${var.project}-origin-${var.environment}"
  }
}

resource "aws_s3_bucket" "origin-log" {
  bucket = "${var.project}-origin-log-${var.environment}"
  acl    = "private"
  tags = {
    Name = "${var.project}-origin-log-${var.environment}"
  }
}

locals {
  s3_origin_id = "${var.project}-S3Origin-${var.environment}"
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "only cloudfront access - ${var.project} - ${var.environment}"
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = aws_s3_bucket.origin.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  aliases = [ var.cname ]

  enabled             = true
  is_ipv6_enabled     = false
  comment             = "${var.project} CDN - ${var.environment}"
  default_root_object = var.default_root_object

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.origin-log.bucket_regional_domain_name
    prefix          = var.environment
  }

  custom_error_response {
    error_caching_min_ttl = 60 
    error_code            = 403 
    response_code         = 200 
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 60 
    error_code            = 404 
    response_code         = 200 
    response_page_path    = "/index.html"
  }

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  price_class = var.price_class

  tags = {
    Environment = var.environment
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn            = "arn:aws:acm:us-east-1:790261131557:certificate/aebb18be-a4cf-4e92-b7d4-79109dc75407"
    minimum_protocol_version       = "TLSv1.2_2018"
    ssl_support_method             = "sni-only" 
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
    }
  }
}
