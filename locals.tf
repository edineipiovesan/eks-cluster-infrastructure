locals {
  cluster_name    = "argocd-cluster"
  cluster_version = "1.22"
  region          = "us-east-1"

  tags = {
    Cluster   = local.cluster_name
    Version   = "1.0"
    ManagedBy = "Terraform"
  }
}