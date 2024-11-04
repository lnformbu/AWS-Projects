# providers.tf - Provider configuration

provider "aws" {
  region = "us-east-1"

}

terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.66, < 5.67.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.5"
    }
  }

  # Save State file on terraform cloud or S3
  cloud {
    organization = "AWS-100DaysofDevOps"
    workspaces {
      name = "100DaysDevOps"
    }
  }

  # # uncomment if using s3 bucket for remote state

  #   backend "s3" {
  #     bucket = "tfstate-lab-001"
  #     key    = "~/.aws/credentials"
  #     region = "us-east-1"

  #   }

}
