#######################################
# Root main.tf – Calls VPC Module
#######################################

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

