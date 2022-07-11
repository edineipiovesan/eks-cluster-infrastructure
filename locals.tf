locals {
  cluster_name    = "edn-tech-cluster"
  cluster_version = "1.22"
  region          = "us-east-1"

  tags = {
    Cluster   = local.cluster_name
    Version   = "1.0"
    ManagedBy = "Terraform"
  }
}