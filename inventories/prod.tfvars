aws_region = "us-east-1"

eks_cluster_name    = "aws-workshop-metrics"
eks_cluster_version = "1.27"
eks_cluster_addons = {
  kube-proxy = { resolve_conflicts = "OVERWRITE" }
  vpc-cni    = { resolve_conflicts = "OVERWRITE" }
  coredns    = { resolve_conflicts = "OVERWRITE" }
}
eks_fargate_profile = {
  default = {
    namespace = "default"
    role      = "arn:aws:iam::257254804006:role/AmazonEKSFargatePodExecutionRole"
  }
  kube-system = {
    namespace = "kube-system"
    role      = "arn:aws:iam::257254804006:role/AmazonEKSFargatePodExecutionRole"
  }
  workshop = {
    namespace = "workshop"
    role      = "arn:aws:iam::257254804006:role/AmazonEKSFargatePodExecutionRole"
  }
}

ecr_repository_name = "edn-tech-repository"

default_tags = {
  CreatedBy = "eks-fargate-cluster-infrastructure"
  ManagedBy = "Terraform"
  Version   = "0.1"
}