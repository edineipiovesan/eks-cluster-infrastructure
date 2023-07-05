aws_region = "us-east-1"

vpc_id = "vpc-082ea38c5fbd12a91"
public_subnets = [
  "subnet-06021a2ec84d6ed22",
  "subnet-01b0e384ea7a7c4de",
  "subnet-09472af23f8cec280",
]
private_subnets = [
  "subnet-0a511c5b421f156ba",
  "subnet-0c1cb12b6822804df",
  "subnet-07b2bc940982be1ca",
]
bastion_host_sg       = "sg-00fd1d429e22568ba"
bastion_host_role_arn = "arn:aws:iam::257254804006:role/BastionRole"

eks_cluster_name    = "edn-tech-k8s-cluster-1"
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

ecr_repository_name = "edn-tech-container-images"

default_tags = {
  CreatedBy = "eks-fargate-cluster-infrastructure"
  ManagedBy = "Terraform"
  Version   = "0.1"
}