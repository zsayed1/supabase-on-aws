module "eks" {
  source = "./modules/eks"

  cluster_name       = var.eks_cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids

  desired_capacity = var.eks_desired_capacity
  max_capacity     = var.eks_max_capacity
  min_capacity     = var.eks_min_capacity
  instance_type    = var.eks_instance_type
}