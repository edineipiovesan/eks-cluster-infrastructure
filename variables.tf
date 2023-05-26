############
### AWS ###
############
variable "aws_region" {
  type        = string
  description = "AWS Region used to deploy project resources"
  default     = "us-east-1"
}

############
### EKS ###
############
variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "eks_cluster_version" {
  type        = string
  description = "EKS cluster version"
}

variable "eks_cluster_addons" {
  type = map(object({
    resolve_conflicts = string
  }))
  description = "Addons for EKS cluster"
}

variable "eks_fargate_profile" {
  type = map(object({
    namespace = string
    role      = string
  }))
}

############
### ECR ###
############
variable "ecr_repository_name" {
  type        = string
  description = "ECR Image repository"
}

############
### TAGS ###
############
variable "default_tags" {
  type        = map(string)
  description = "Default tags added to all resources provisioned by this project"
}
