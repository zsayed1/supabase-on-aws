variable "supabase_jwt_secret" {
  description = "JWT secret used by Supabase auth (maps to JWT_SECRET)"
  type        = string
  sensitive   = true
}

variable "supabase_service_role_key" {
  description = "Supabase service role key (maps to SERVICE_ROLE_KEY)"
  type        = string
  sensitive   = true
}

variable "supabase_anon_key" {
  description = "Supabase anon key (maps to ANON_KEY)"
  type        = string
  sensitive   = true
}

variable "supabase_s3_bucket" {
  description = "Supabase S3 bucket name (maps to STORAGE_S3_BUCKET)"
  type        = string
}

variable "supabase_s3_region" {
  description = "Supabase S3 region (maps to STORAGE_S3_REGION)"
  type        = string
}

# Optional SMTP creds for GoTrue
variable "supabase_smtp_user" {
  description = "SMTP user (maps to GOTRUE_SMTP_USER)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "supabase_smtp_pass" {
  description = "SMTP password (maps to GOTRUE_SMTP_PASS)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all Supabase secrets"
  type        = map(string)
  default     = {}
}
