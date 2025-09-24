output "cluster_id" {
  value = aws_eks_cluster.this.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "node_group_name" {
  value = aws_eks_node_group.this.node_group_name
}

output "supabase_secrets_irsa_role_arn" {
  description = "IAM role ARN for Supabase secrets access"
  value       = aws_iam_role.supabase_secrets_irsa.arn
}