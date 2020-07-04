variable "project" {
    type = string
    description = "Project Name"
}

variable "environment" {
    type = string
    description = "Environment"
}

variable "default_root_object" {
  type = string
  default = "index.html"
  description = "Default object in CDN"
}

variable "allowed_methods" {
  type = list(string)
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "Allowed http methods in CDN"
}

variable "cached_methods" {
  type = list(string)
  default = ["GET", "HEAD"]
}

variable "price_class" {
  type = string
  default = "PriceClass_All"
  description = "Price Class"
}

variable "default_ttl" {
  type = number
  default = 3600
}

variable "max_ttl" {
  type = number
  default = 86400
}

variable "cloudfront_default_certificate" {
  type = bool
  default = true
}

variable "restriction_type" {
  type = string
  default = "none"
}
