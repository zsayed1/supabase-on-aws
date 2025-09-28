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

variable "eks_api_allowed_cidrs" {
  description = "CIDR blocks allowed to access the EKS public API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"] # ⚠️ open; override in tfvars
}

variable "supabase_secret_arn" {
  description = "ARN of the Supabase secret in Secrets Manager"
  type        = string
}

variable "enable_ebs_csi_driver" {
  description = "Whether to enable the EBS CSI driver addon"
  type        = bool
  default     = true
}

variable "eks_version" {
  type        = string

  description = "EKS version to use for worker AMIs"
  default     = "1.31"
}