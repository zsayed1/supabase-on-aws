variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "Map of public subnet CIDRs keyed by AZ"
  type        = map(string)
}

variable "private_subnets" {
  description = "Map of private subnet CIDRs keyed by AZ"
  type        = map(string)
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-west-1"
}

# EKS Vars
variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "eks_desired_capacity" {
  type        = number
  description = "Desired worker node count"
}

variable "eks_min_capacity" {
  type        = number
  description = "Minimum worker node count"
}

variable "eks_max_capacity" {
  type        = number
  description = "Maximum worker node count"
}

variable "eks_instance_type" {
  type        = string
  description = "EC2 instance type for workers"
}

## DB Variables

variable "db_name" {
  type = string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "db_engine_version" {
  type    = string
  default = "15.5"
}
variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}
variable "db_max_allocated_storage" {
  type    = number
  default = 100
}

variable "db_multi_az" {
  type    = bool
  default = true
}
variable "db_backup_retention_period" {
  type    = number
  default = 7
}
variable "db_backup_window" {
  type    = string
  default = "03:00-04:00"
}
variable "db_maintenance_window" {
  type    = string
  default = "sun:04:00-sun:05:00"
}
variable "db_performance_insights_enabled" {
  type    = bool
  default = true
}
variable "db_deletion_protection" {
  type    = bool
  default = false
}
variable "db_kms_key_id" {
  type    = string
  default = ""
}

variable "db_allowed_cidr_blocks" {
  description = "CIDRs allowed to connect to DB; defaults to VPC CIDR if empty"
  type        = list(string)
  default     = []
}

variable "db_create_credentials_secret" {
  type    = bool
  default = true
}
variable "db_secret_name" {
  type    = string
  default = "rds-postgres-credentials"
}
