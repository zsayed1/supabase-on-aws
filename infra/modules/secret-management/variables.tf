variable "db_name" {
  description = "Name of the Postgres database"
  type        = string
}

variable "db_username" {
  description = "Username for the Postgres database"
  type        = string
}

variable "db_password" {
  description = "Generated or provided DB password"
  type        = string
}

variable "db_host" {
  description = "RDS endpoint for Postgres"
  type        = string
}

variable "db_port" {
  description = "Port for Postgres"
  type        = number
  default     = 5432
}

variable "s3_bucket" {
  description = "Supabase S3 bucket name"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the deployment"
  type        = string
}
