locals {
  # If user didn't supply a password, generate one
  db_password_effective = var.db_password != "" ? var.db_password : random_password.db.result

  # Default allow-list = VPC CIDR unless caller provides a list
  allow_cidrs = length(var.db_allowed_cidr_blocks) > 0 ? var.db_allowed_cidr_blocks : [var.vpc_cidr]
}

# Generate a strong password only when needed
resource "random_password" "db" {
  length           = 24
  special          = true
  override_special = "!@#%^*-_=+"
}

# Security Group for DB: allow Postgres only from allowed CIDRs
resource "aws_security_group" "db" {
  name        = "rds-postgres-sg"
  description = "Postgres access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = local.allow_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]   # ✅ restrict to VPC only
  }

  tags = {
    Name = "rds-postgres-sg"
  }
}


# Subnet group in private subnets
resource "aws_db_subnet_group" "this" {
  name       = "rds-postgres-subnets"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "rds-postgres-subnets"
  }
}

# Optionally a custom parameter group (example: turn on log_min_duration_statement)
resource "aws_db_parameter_group" "this" {
  name   = "rds-postgres-params"
  family = "postgres${split(".", var.engine_version)[0]}"

  # example parameter (adjust as needed)
  parameter {
    name  = "log_min_duration_statement"
    value = "2000"
  }

  tags = {
    Name = "rds-postgres-params"
  }
}

# The RDS instance
resource "aws_db_instance" "postgres" {
  identifier                 = "supabase-postgres"
  engine                     = "postgres"
  engine_version             = var.engine_version
  instance_class             = var.instance_class
  deletion_protection        = var.deletion_protection
  skip_final_snapshot        = true
  final_snapshot_identifier = "${var.db_name}-final-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  db_name                    = var.db_name
  username                   = var.db_username
  password                   = local.db_password_effective
  port                       = var.db_port

  # Networking
  db_subnet_group_name       = aws_db_subnet_group.this.name
  vpc_security_group_ids     = [aws_security_group.db.id]
  publicly_accessible        = false
  multi_az                   = var.multi_az

  # Storage
  allocated_storage          = var.allocated_storage
  max_allocated_storage      = var.max_allocated_storage
  storage_encrypted          = true
  kms_key_id                 = var.kms_key_id != "" ? var.kms_key_id : null

  # Backups & Maintenance
  backup_retention_period    = var.backup_retention_period
  backup_window              = var.backup_window
  maintenance_window         = var.maintenance_window
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot      = true
  # deletion_protection        = var.deletion_protection

  # Monitoring
  performance_insights_enabled = var.performance_insights_enabled

  apply_immediately          = false

  depends_on = [aws_db_parameter_group.this]
  parameter_group_name = aws_db_parameter_group.this.name

  tags = {
    Name        = "supabase-postgres"
    Environment = "demo"
    Project     = "supabase"
  }
}

# Store connection info in Secrets Manager (optional)
resource "aws_secretsmanager_secret" "creds" {
  count = var.create_credentials_secret ? 1 : 0
  name  = var.secret_name
  tags = {
    Name = var.secret_name
  }
}

resource "aws_secretsmanager_secret_version" "creds_v" {
  count     = var.create_credentials_secret ? 1 : 0
  secret_id = aws_secretsmanager_secret.creds[0].id
  secret_string = jsonencode({
    engine   = "postgres"
    host     = aws_db_instance.postgres.address
    port     = var.db_port
    username = var.db_username
    password = local.db_password_effective
    dbname   = var.db_name
    arn      = aws_db_instance.postgres.arn
  })
}
