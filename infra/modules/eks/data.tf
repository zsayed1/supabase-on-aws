# Look up latest EKS optimized AMI for your version/region
# Get cluster details
data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.this.name
}

data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
}

# Find latest Amazon EKS-optimized AMI
data "aws_ami" "eks_worker" {
  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI account

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.eks_version}-*"]
  }
}
