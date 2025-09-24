output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of all public subnets"
  value       = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  description = "IDs of all private subnets"
  value       = [for s in aws_subnet.private : s.id]
}
