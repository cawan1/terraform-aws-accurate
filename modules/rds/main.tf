data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "db" {
  name        = "allow ${var.project} rds access-${var.environment}"
  description = "Allow public rds access"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description = "Liberado public access to db_port"
    from_port   = var.db_instance_port
    to_port     = var.db_instance_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-RDS-public_accesss-${var.environment}"
  }
}

data "aws_subnet_ids" "db" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "cidr-block"
    values = var.database_subnets # insert values here
  }
}

module "db" {

  source = "github.com/terraform-aws-modules/terraform-aws-rds.git"


  identifier = "${var.project}-${var.db_engine}-${var.environment}"

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  storage_type      = var.db_storage_type
  allocated_storage = var.db_allocated_storage
  storage_encrypted = false

  # kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
  name = "${var.project}db${var.environment}"

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username = var.db_username

  password = var.db_password
  port     = var.db_instance_port

  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = true

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = {
    Environment = var.environment
  }

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # DB subnet group
  subnet_ids = data.aws_subnet_ids.db.ids

  # DB parameter group
  family = var.db_family

  # DB option group
  major_engine_version = var.db_major_engine_version

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "${var.project}db-${var.environment}"

  # Database Deletion Protection
  deletion_protection = false
}
