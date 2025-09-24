# AWS region
aws_region = "us-west-1"

# VPC CIDR
vpc_cidr = "10.0.0.0/16"

# Availability Zones in us-west-1
azs = [
  "us-west-1a",
  "us-west-1c"
]

# Public subnets (2 total, 1 per AZ)
public_subnets = {
  "us-west-1a" = "10.0.1.0/24"
  "us-west-1c" = "10.0.2.0/24"
}

# Private subnets (2 total, 1 per AZ)
private_subnets = {
  "us-west-1a" = "10.0.101.0/24"
  "us-west-1c" = "10.0.102.0/24"
}


## EKS cluster vars

eks_cluster_name    = "supabase-eks"
eks_desired_capacity = 2
eks_min_capacity     = 1
eks_max_capacity     = 4
eks_instance_type    = "t3.medium"
