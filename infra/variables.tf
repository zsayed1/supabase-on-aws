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

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-west-1"
}

# EKS Vars
variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "eks_desired_capacity" {
  type        = number
  description = "Desired worker node count"
}

variable "eks_min_capacity" {
  type        = number
  description = "Minimum worker node count"
}

variable "eks_max_capacity" {
  type        = number
  description = "Maximum worker node count"
}

variable "eks_instance_type" {
  type        = string
  description = "EC2 instance type for workers"
}
