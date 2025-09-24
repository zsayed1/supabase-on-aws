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