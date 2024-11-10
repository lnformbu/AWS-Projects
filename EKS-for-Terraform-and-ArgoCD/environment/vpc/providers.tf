
# Define the Terraform configuration
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.73.0"
    }
    random = {
      version = ">= 3"
    }
  }
  # I am using terraform cloud for my backend.
  cloud {
    organization = "AWS-100DaysofDevOps"
    workspaces {
      name = "100DaysDevOps"
    }
  }
}

# Configure the AWS provider for the primary region
provider "aws" {
  region = "us-east-1" # Set the AWS region to US East (N. Virginia)
}

provider "random" {
  # Configuration options
}

