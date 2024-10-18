terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.67.0"
    }
  }

  cloud {
    organization = "AWS-100DaysofDevOps"
    workspaces {
      name = "100DaysDevOps"
    }
  }

}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}