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