resource "aws_eks_fargate_profile" "this" {
  for_each = var.eks_fargate_profile

  cluster_name           = data.aws_eks_cluster.cluster.name
  fargate_profile_name   = each.key
  pod_execution_role_arn = each.value.role
  subnet_ids             = module.vpc.private_subnets

  selector {
    namespace = each.value.namespace
  }

  timeouts {
    create = "20m"
    delete = "20m"
  }

  tags = var.default_tags

  depends_on = [
    data.aws_eks_cluster.cluster
  ]
}
