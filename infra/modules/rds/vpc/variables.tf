variable "vpc_id" {
  description = "The ID of the VPC where RDS will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where RDS will run"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "VPC CIDR used as a default allow list for DB access"
  type        = string
}

variable "db_name" {
  description = "Initial PostgreSQL database name"
  type        = string
}

variable "db_username" {
  description = "Master username for PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "Master password for PostgreSQL (leave empty to auto-generate)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "15.5"
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial storage size (in GiB)"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage size for autoscaling (in GiB)"
  type        = number
  default     = 100
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment for high availability"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred daily backup window (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Preferred maintenance window (UTC)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights for monitoring"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Protect DB from being accidentally deleted"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "KMS key ID for storage encryption (leave empty to use AWS default)"
  type        = string
  default     = ""
}

variable "db_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to DB (defaults to VPC CIDR)"
  type        = list(string)
  default     = []
}

variable "create_credentials_secret" {
  description = "Whether to create an AWS Secrets Manager secret for DB credentials"
  type        = bool
  default     = true
}

variable "secret_name" {
  description = "Name of the AWS Secrets Manager secret if created"
  type        = string
  default     = "rds-postgres-credentials"
}
