
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnets         = var.subnets
  vpc_id          = var.vpc_id
  enable_irsa     = true

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 4
      min_size     = 1
      instance_types = ["t3.medium"]
      tags = {
        Name        = "${var.env}-worker-node"
        Environment = var.env
        Role        = "worker"
      }
    }
  }

  tags = {
    Environment = var.env
    Terraform   = "true"
  }
}
