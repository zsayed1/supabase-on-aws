############################
# VPC Variables
############################
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"]
}

variable "public_subnets" {
  description = "Map of public subnet CIDRs per AZ"
  type        = map(string)
  default = {
    "us-west-1a" = "10.0.1.0/24"
    "us-west-1c" = "10.0.2.0/24"
  }
}

variable "private_subnets" {
  description = "Map of private subnet CIDRs per AZ"
  type        = map(string)
  default = {
    "us-west-1a" = "10.0.101.0/24"
    "us-west-1c" = "10.0.102.0/24"
  }
}

############################
# EKS Variables
############################
variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "supabase-eks"
}

variable "eks_desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "eks_min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "eks_max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "eks_instance_type" {
  description = "Instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

############################
# RDS Variables
############################
variable "db_name" {
  description = "Initial PostgreSQL database name"
  type        = string
  default     = "supabase"
}

variable "db_username" {
  description = "Master username for PostgreSQL"
  type        = string
  default     = "supabase_admin"
}

variable "db_password" {
  description = "Master password for PostgreSQL (leave empty to auto-generate)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "15.5"
}

variable "db_instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Initial storage size (in GiB)"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Maximum storage size for autoscaling (in GiB)"
  type        = number
  default     = 100
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = true
}

variable "db_backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "Preferred daily backup window (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  description = "Preferred maintenance window (UTC)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "db_performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "db_deletion_protection" {
  description = "Protect DB from accidental deletion"
  type        = bool
  default     = false
}

variable "db_kms_key_id" {
  description = "KMS key ID for storage encryption (empty = AWS default)"
  type        = string
  default     = ""
}

variable "db_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to DB"
  type        = list(string)
  default     = []
}

variable "db_create_credentials_secret" {
  description = "Whether to create an AWS Secrets Manager secret for DB creds"
  type        = bool
  default     = true
}

variable "db_secret_name" {
  description = "Name of the AWS Secrets Manager secret"
  type        = string
  default     = "rds-postgres-credentials"
}
