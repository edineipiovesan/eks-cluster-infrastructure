locals {
  addons = { for i in keys(data.aws_eks_addon_version.default) : i => {
    name              = data.aws_eks_addon_version.default[i].id,
    version           = data.aws_eks_addon_version.default[i].version,
    resolve_conflicts = var.eks_cluster_addons[i].resolve_conflicts
    }
  }
}

data "aws_eks_addon_version" "default" {
  for_each = var.eks_cluster_addons

  addon_name         = each.key
  kubernetes_version = module.eks.cluster_version
  most_recent        = true
}

resource "aws_eks_addon" "this" {
  for_each = local.addons

  cluster_name      = module.eks.cluster_name
  addon_name        = each.value.name
  addon_version     = each.value.version
  resolve_conflicts = each.value.resolve_conflicts
  tags              = var.default_tags

  depends_on = [
    aws_eks_fargate_profile.this
  ]
}