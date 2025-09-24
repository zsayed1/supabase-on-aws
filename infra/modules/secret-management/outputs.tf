output "supabase_secrets_arns" {
  description = "Map of Supabase secret names to ARNs"
  value       = { for k, v in aws_secretsmanager_secret.supabase : k => v.arn }
}
