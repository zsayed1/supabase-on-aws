locals {
  secrets = {
    "supabase-jwt-secret"        = var.supabase_jwt_secret
    "supabase-service-role-key"  = var.supabase_service_role_key
    "supabase-anon-key"          = var.supabase_anon_key
    "supabase-s3-bucket"         = var.supabase_s3_bucket
    "supabase-s3-region"         = var.supabase_s3_region

    # Optional SMTP
    "supabase-smtp-user"         = var.supabase_smtp_user
    "supabase-smtp-pass"         = var.supabase_smtp_pass
  }
}

# Create one secret per entry
resource "aws_secretsmanager_secret" "supabase" {
  for_each = local.secrets
  name     = each.key
  tags     = var.tags
}

resource "aws_secretsmanager_secret_version" "supabase" {
  for_each      = local.secrets
  secret_id     = aws_secretsmanager_secret.supabase[each.key].id
  secret_string = each.value
}
