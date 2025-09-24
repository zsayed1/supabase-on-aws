variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for worker nodes"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
}
