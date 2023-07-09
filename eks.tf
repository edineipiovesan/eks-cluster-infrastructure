module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.15"

  cluster_name                          = var.eks_cluster_name
  cluster_version                       = var.eks_cluster_version
  cluster_endpoint_private_access       = true
  cluster_endpoint_public_access        = false
  cluster_additional_security_group_ids = [var.bastion_host_sg, var.pipeline_sg]
  enable_irsa                           = true
  vpc_id                                = var.vpc_id
  subnet_ids                            = var.private_subnets
  tags                                  = var.default_tags
  cluster_enabled_log_types             = ["audit", "api", "authenticator", "scheduler", "controllerManager"]
  manage_aws_auth_configmap             = true
  aws_auth_roles                        = [var.bastion_host_role_arn]

  cluster_encryption_config = {
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name

  depends_on = [module.eks.cluster_endpoint]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name

  depends_on = [module.eks.cluster_endpoint]
}
