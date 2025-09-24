output "db_endpoint" {
  value     = aws_db_instance.postgres.address
  sensitive = false
}

output "db_identifier" {
  value = aws_db_instance.postgres.id
}

output "db_security_group_id" {
  value = aws_security_group.db.id
}

output "db_secret_arn" {
  value     = try(aws_secretsmanager_secret.creds[0].arn, null)
  sensitive = true
}

output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.postgres.db_name
}

output "db_username" {
  description = "The master username for the database"
  value       = aws_db_instance.postgres.username
  sensitive   = true
}

output "db_password" {
  description = "The master password for the database (from random_password)"
  value       = local.db_password_effective
  sensitive   = true
}