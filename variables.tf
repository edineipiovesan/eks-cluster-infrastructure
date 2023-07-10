############
### AWS ###
############
variable "aws_region" {
  type        = string
  description = "AWS Region used to deploy project resources"
  default     = "us-east-1"
}

##################
### Networking ###
##################
variable "vpc_id" {
  type        = string
  description = "VPC used by kubernetes cluster"
}

variable "private_subnets" {
  type        = set(string)
  description = "Private subnets"
}

variable "public_subnets" {
  type        = set(string)
  description = "Public subnets"
}

variable "bastion_host_sg" {
  type        = string
  description = "Bastion host security group allowed"
  validation {
    condition     = can(regex("^sg-", var.bastion_host_sg))
    error_message = "Security group id starts with sg-*"
  }
}

variable "bastion_host_role" {
  type        = string
  description = "Bastion host IAM role"
  validation {
    condition     = can(regex("^arn:aws:iam:", var.bastion_host_role))
    error_message = "Role arn starts with arn:aws:iam:*"
  }
}

variable "pipeline_sg" {
  type        = string
  description = "Pipeline security group allowed"
  validation {
    condition     = can(regex("^sg-", var.pipeline_sg))
    error_message = "Security group id starts with sg-*"
  }
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
