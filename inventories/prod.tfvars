aws_region = "us-east-1"

vpc_id = "vpc-013d05c418c10210f"
public_subnets = [
  "subnet-06712f91cdb9367c9",
  "subnet-061ea6402c42abf42",
  "subnet-02cd19e60b339c6cd",
]
private_subnets = [
  "subnet-0f9ec8c04a0a459ac",
  "subnet-0e9831282b90dada7",
  "subnet-03f04a6ae392e9a96",
]
bastion_host_sg = "sg-0d650373748600386"
bastion_host_role = {
  rolearn  = "arn:aws:iam::257254804006:role/BastionRole"
  username = "bastion-host"
  groups   = ["system:master"]
}
pipeline_sg = "sg-05dc2e6ca161f7297"

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