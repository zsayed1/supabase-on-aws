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
eks_api_allowed_cidrs = ["98.212.28.32/32"] # replace with your actual IP

# --- DB (RDS Postgres) ---
db_name     = "supabase"
db_username = "supabase_admin"
db_password = ""                   ## Please leave empty to auto generate by using random and storee in secret manager

db_engine_version         = "17.6"
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


# S3 for Supabase
storage_bucket_name               = "supabase-demo-storage-usw1"  # pick a unique name
storage_versioning_enabled        = true
storage_force_destroy             = false
storage_kms_key_id                = ""    # or "arn:aws:kms:us-west-1:123456789012:key/abcd-..."
# storage_cors_allowed_origins      = ["https://your-supabase-project-url", "http://localhost:3000"]
# storage_cors_allowed_methods      = ["GET", "PUT", "POST", "DELETE", "HEAD"]
# storage_cors_allowed_headers      = ["*"]
# storage_cors_expose_headers       = ["etag"]
storage_lifecycle_expiration_days = 0
