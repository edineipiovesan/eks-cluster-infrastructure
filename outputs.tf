############
### EKS ###
############
output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

############
### EKS ###
############
output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS endpoint for control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_platform_version" {
  description = "Cluster platform version"
  value       = module.eks.cluster_platform_version
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.eks.cluster_arn
}

############
### ECR ###
############
output "ecr_url" {
  description = "ECR repository url"
  value       = aws_ecr_repository.ecr.repository_url
}