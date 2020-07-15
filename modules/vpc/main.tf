module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git"

  name = "${var.project}-vpc-${var.environment}"

  cidr = var.cidr 
  azs              = var.azs
  # private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets

  #reuse_nat_ips = true

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  # #Single NAT Gateway
  # enable_nat_gateway     = true
  # single_nat_gateway     = true
  # one_nat_gateway_per_az = false

  #enable_vpn_gateway = true

  # VPC endpoint for S3
  #enable_s3_endpoint = true

  # VPC endpoint for DynamoDB
  #enable_dynamodb_endpoint = true

  tags = {
    Environment = var.environment
    Name        = "vpc-${var.project}-${var.environment}"
  }

}
