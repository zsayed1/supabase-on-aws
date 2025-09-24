resource "random_password" "jwt_secret" {
  length  = 32
  special = false
}

resource "random_password" "service_role" {
  length  = 40
  special = false
}

resource "random_password" "anon_key" {
  length  = 40
  special = false
}

resource "aws_secretsmanager_secret_version" "supabase" {
  secret_id     = aws_secretsmanager_secret.supabase.id
  secret_string = jsonencode({
    JWT_SECRET       = random_password.jwt_secret.result
    SERVICE_ROLE_KEY = random_password.service_role.result
    ANON_KEY         = random_password.anon_key.result

    DB_HOST     = module.rds.db_endpoint
    DB_PORT     = "5432"
    DB_NAME     = var.db_name
    DB_USER     = var.db_username
    DB_PASSWORD = random_password.db.result
    STORAGE_BACKEND   = "s3"
    STORAGE_S3_BUCKET = module.supabase_storage.bucket_name
    STORAGE_S3_REGION = var.aws_region
  })
}
