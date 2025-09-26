module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.eks_cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids

  desired_capacity = var.eks_desired_capacity
  max_capacity     = var.eks_max_capacity
  min_capacity     = var.eks_min_capacity
  instance_type    = var.eks_instance_type
  
  eks_api_allowed_cidrs = var.eks_api_allowed_cidrs
  supabase_secret_arn   = module.supabase_secrets.supabase_secret_arn
}


# module "rds" {
#   source = "./modules/rds"

#   vpc_id             = module.vpc.vpc_id
#   private_subnet_ids = module.vpc.private_subnet_ids
#   vpc_cidr           = var.vpc_cidr

#   db_name            = var.db_name
#   db_username        = var.db_username
#   db_password        = var.db_password # can be empty to auto-generate

#   engine_version        = var.db_engine_version
#   instance_class        = var.db_instance_class
#   allocated_storage     = var.db_allocated_storage
#   max_allocated_storage = var.db_max_allocated_storage

#   multi_az                     = var.db_multi_az
#   backup_retention_period      = var.db_backup_retention_period
#   backup_window                = var.db_backup_window
#   maintenance_window           = var.db_maintenance_window
#   performance_insights_enabled = var.db_performance_insights_enabled
#   deletion_protection          = var.db_deletion_protection
#   kms_key_id                   = var.db_kms_key_id

#   db_allowed_cidr_blocks    = var.db_allowed_cidr_blocks
#   create_credentials_secret = var.db_create_credentials_secret
#   secret_name               = var.db_secret_name
# }

# module "supabase_storage" {
#   source = "./modules/s3"

#   bucket_name             = var.storage_bucket_name
#   versioning_enabled      = var.storage_versioning_enabled
#   force_destroy           = var.storage_force_destroy
#   kms_key_id              = var.storage_kms_key_id
# #   cors_allowed_origins    = var.storage_cors_allowed_origins
# #   cors_allowed_methods    = var.storage_cors_allowed_methods
# #   cors_allowed_headers    = var.storage_cors_allowed_headers
# #   cors_expose_headers     = var.storage_cors_expose_headers
#   lifecycle_expiration_days = var.storage_lifecycle_expiration_days

#   tags = {
#     Project     = "supabase"
#     Environment = "demo"
#   }
# }

# module "supabase_secrets" {
#   source = "./modules/secret-management"

#   db_name     = module.rds.db_name
#   db_username = module.rds.db_username
#   db_password = module.rds.db_password
#   db_host     = module.rds.db_endpoint
#   db_port     = 5432

#   s3_bucket   = module.supabase_storage.bucket_name
#   aws_region  = var.aws_region
# }
