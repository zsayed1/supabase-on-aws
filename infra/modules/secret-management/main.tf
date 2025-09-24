# Generate Supabase secrets
resource "random_password" "jwt_secret" {
  length  = 32
  special = false
}

resource "random_password" "service_role_key" {
  length  = 40
  special = false
}

resource "random_password" "anon_key" {
  length  = 40
  special = false
}

# Create Secrets Manager secret
resource "aws_secretsmanager_secret" "supabase" {
  name = "supabase-app-secrets"
}

# Store all values in JSON
resource "aws_secretsmanager_secret_version" "supabase" {
  secret_id = aws_secretsmanager_secret.supabase.id
  secret_string = jsonencode({
    JWT_SECRET       = random_password.jwt_secret.result
    SERVICE_ROLE_KEY = random_password.service_role_key.result
    ANON_KEY         = random_password.anon_key.result

    DB_HOST     = var.db_host
    DB_PORT     = var.db_port
    DB_NAME     = var.db_name
    DB_USER     = var.db_username
    DB_PASSWORD = var.db_password

    STORAGE_BACKEND   = "s3"
    STORAGE_S3_BUCKET = var.s3_bucket
    STORAGE_S3_REGION = var.aws_region
  })
}
