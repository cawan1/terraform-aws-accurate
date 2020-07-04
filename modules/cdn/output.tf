output "cdn_domainname" {
  value = aws_cloudfront_distribution.this.domain_name
  description = "CDN Domain name"
}
