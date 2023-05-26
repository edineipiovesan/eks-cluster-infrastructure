terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }

  required_version = ">= 1.4.6"
}

