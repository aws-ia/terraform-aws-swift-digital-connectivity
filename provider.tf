terraform {
  required_version = ">= 1.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73.0"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = ">= 0.21.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.3.0"
    }
  }
}