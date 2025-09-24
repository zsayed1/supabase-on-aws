variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "Map of public subnet CIDRs keyed by AZ"
  type        = map(string)
}

variable "private_subnets" {
  description = "Map of private subnet CIDRs keyed by AZ"
  type        = map(string)
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_desired_capacity" {
  description = "Desired worker node count"
  type        = number
}

variable "eks_min_capacity" {
  description = "Minimum worker node count"
  type        = number
}

variable "eks_max_capacity" {
  description = "Maximum worker node count"
  type        = number
}

variable "eks_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
}
