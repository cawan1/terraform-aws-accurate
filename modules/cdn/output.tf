output "cdn_domainname" {
  value = aws_cloudfront_distribution.this.domain_name
  description = "CDN Domain name"
}


output "distribution_id" {
  value = aws_cloudfront_distribution.this.id
  description = "CDN Distribution ID"
}
