# main.tf
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnets         = var.subnets
  vpc_id          = var.vpc_id
  tags            = var.tags
}
