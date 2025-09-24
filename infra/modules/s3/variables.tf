variable "bucket_name" {
  description = "Globally-unique S3 bucket name"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable S3 object versioning"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow Terraform to delete non-empty bucket (careful in prod)"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "KMS key ID/ARN for SSE (empty = SSE-S3 AES256)"
  type        = string
  default     = ""
}

# variable "cors_allowed_origins" {
#   description = "List of allowed origins for CORS (e.g., your Supabase URL)"
#   type        = list(string)
#   default     = []
# }

# variable "cors_allowed_methods" {
#   description = "CORS methods"
#   type        = list(string)
#   default     = ["GET", "PUT", "POST", "DELETE", "HEAD"]
# }

# variable "cors_allowed_headers" {
#   description = "CORS headers"
#   type        = list(string)
#   default     = ["*"]
# }

# variable "cors_expose_headers" {
#   description = "CORS expose headers"
#   type        = list(string)
#   default     = ["etag"]
# }

variable "lifecycle_expiration_days" {
  description = "Optional: expire non-current versions after N days (0 = disabled)"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags to apply to bucket"
  type        = map(string)
  default     = {}
}
