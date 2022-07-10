terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.21.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.2.2"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.12.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.7.2"
    }
  }

  required_version = ">= 1.2.4"
}

