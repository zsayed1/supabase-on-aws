output "supabase_secret_name" {
  description = "Name of the Supabase Secrets Manager secret"
  value       = aws_secretsmanager_secret.supabase.name
}

output "supabase_secret_arn" {
  description = "ARN of the Supabase Secrets Manager secret"
  value       = aws_secretsmanager_secret.supabase.arn
}
