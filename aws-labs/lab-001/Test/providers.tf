# providers.tf - Provider configuration

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.67.0"
    }
  }
}
