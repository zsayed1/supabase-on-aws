output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "db_security_group_id" {
  value = module.rds.db_security_group_id
}

output "supabase_storage_bucket_name" {
  value = module.supabase_storage.bucket_name
}

output "supabase_storage_bucket_arn" {
  value = module.supabase_storage.bucket_arn
}

output "supabase_secrets_irsa_role_arn" {
  description = "IAM Role ARN for Supabase IRSA"
  value       = module.eks.supabase_secrets_irsa_role_arn
}