module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.26"

  cluster_name                    = local.cluster_name
  cluster_version                 = local.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  enable_irsa                     = true
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = flatten([module.vpc.public_subnets, module.vpc.private_subnets])
  tags                            = local.tags

  cluster_addons = {
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
      version           = "v1.22.6-eksbuild.1"
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
      version           = "v1.11.2-eksbuild.1"
    }
  }

  cluster_encryption_config = [{
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }]

  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "default"
        },
        {
          namespace = "kube-system"
        }
      ]
      subnet_ids = flatten([module.vpc.private_subnets])

      tags = merge({
        Owner = "default"
      }, local.tags)

      timeouts = {
        create = "20m"
        delete = "20m"
      }
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

resource "aws_kms_key" "eks" {
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = local.tags
}

resource "aws_eks_addon" "core-dns" {
  cluster_name      = module.eks.cluster_id
  addon_name        = "coredns"
  addon_version     = "v1.8.7-eksbuild.1"
  resolve_conflicts = "OVERWRITE"
  tags              = local.tags

  depends_on = [
    module.eks.fargate_profiles
  ]
}
