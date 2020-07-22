output "dashboard_cdn_arn" {
    description = "Dashboard CDN ARN"
    value = aws_cloudwatch_dashboard.cdn.dashboard_arn
}