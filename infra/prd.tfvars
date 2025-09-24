# AWS region
aws_region = "us-west-1"

# VPC CIDR
vpc_cidr = "10.0.0.0/16"

# Availability Zones in us-west-1
azs = [
  "us-west-1a",
  "us-west-1c"
]

# Public subnets (2 total, 1 per AZ)
public_subnets = {
  "us-west-1a" = "10.0.1.0/24"
  "us-west-1c" = "10.0.2.0/24"
}

# Private subnets (2 total, 1 per AZ)
private_subnets = {
  "us-west-1a" = "10.0.101.0/24"
  "us-west-1c" = "10.0.102.0/24"
}


## EKS cluster vars

eks_cluster_name     = "supabase-eks"
eks_desired_capacity = 2
eks_min_capacity     = 1
eks_max_capacity     = 4
eks_instance_type    = "t3.medium"


# --- DB (RDS Postgres) ---
db_name     = "supabase"
db_username = "supabase_admin"
db_password = ""                   ## Please leave empty to auto generate by using random and storee in secret manager

db_engine_version         = "14.10"
db_instance_class         = "db.t3.micro"
db_allocated_storage      = 20
db_max_allocated_storage  = 100

db_multi_az               = true
db_backup_retention_period = 7
db_backup_window          = "03:00-04:00"
db_maintenance_window     = "sun:04:00-sun:05:00"
db_performance_insights_enabled = true
db_deletion_protection    = false
db_kms_key_id             = ""            # use default AWS-managed key

# Allow only inside VPC by default; override if you need a bastion/CIDR
db_allowed_cidr_blocks    = []

db_create_credentials_secret = true
db_secret_name              = "rds-postgres-credentials"