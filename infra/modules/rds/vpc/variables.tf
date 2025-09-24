variable "vpc_id" {
  description = "VPC ID for security group"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS subnet group (min 2 for Multi-AZ)"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "VPC CIDR used as default allow list to DB (can be overridden)"
  type        = string
}

variable "db_name" {
  description = "Initial DB name"
  type        = string
}

variable "db_username" {
  description = "Master username"
  type        = string
}

variable "db_password" {
  description = "Master password (leave empty to auto-generate)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432
}

variable "engine_version" {
  description = "Postgres engine version"
  type        = string
  default     = "15.5"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial storage in GiB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Autoscaling storage upper bound GiB"
  type        = number
  default     = 100
}

variable "multi_az" {
  description = "Enable Multi-AZ (recommended for HA)"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Days to retain automated backups"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Preferred maintenance window (UTC)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Protect instance from deletion"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "KMS key for storage encryption (optional; default AWS RDS key)"
  type        = string
  default     = ""
}

variable "db_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to DB"
  type        = list(string)
  default     = []
}

variable "create_credentials_secret" {
  description = "Create AWS Secrets Manager secret with DB connection info"
  type        = bool
  default     = true
}

variable "secret_name" {
  description = "Name for the Secrets Manager secret (if created)"
  type        = string
  default     = "rds-postgres-credentials"
}
