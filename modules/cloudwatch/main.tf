data "aws_region" "current" {}

resource "aws_cloudwatch_dashboard" "cdn" {
  dashboard_name = "${var.project}-${var.environment}"

  dashboard_body = <<EOF
{
    "widgets": [
        {
           "type":"metric",
           "x":0,
           "y":0,
           "width": 10,
           "height": 10,
           "properties":{
           "metrics": [
               [ "AWS/CloudFront", "BytesDownloaded", "Region", "Global", "DistributionId", "${var.distribution_id}" ],
               [ ".", "BytesUploaded", ".", ".", ".", "." ],
               [ ".", "Requests", ".", ".", ".", "." ],
               [ ".", "4xxErrorRate", ".", ".", ".", "." ],
               [ ".", "5xxErrorRate", ".", ".", ".", "." ],
               [ ".", "TotalErrorRate", ".", ".", ".", "." ]
           ],
              "period":300,
              "stat":"SampleCount",
              "region":"${data.aws_region.current.name}",
              "title":"AccessLog - CDN - ${var.environment}",
              "view":"timeSeries",
              "stacked": true
           }
        }
    ]
}
EOF
}