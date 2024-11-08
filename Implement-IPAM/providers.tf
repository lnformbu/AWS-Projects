# Define the Terraform configuration
terraform {
  required_providers { # Specify the required providers
    aws = {
      source  = "hashicorp/aws" # Use the official AWS provider from HashiCorp
      version = ">= 5.73.0"
    }
    awscc = {
      source  = "hashicorp/awscc" # Use the official AWS Cloud Control provider from HashiCorp
      version = ">= 1.18.0"
    }
  }

  cloud {                                # Configure Terraform Cloud settings
    organization = "AWS-100DaysofDevOps" # The name of the Terraform Cloud organization
    workspaces {
      name = "100DaysDevOps" # The name of the Terraform Cloud workspace
    }
  }
}

# Configure the AWS provider for the primary region
provider "aws" {
  region = "us-east-1" # Set the AWS region to US East (N. Virginia)
}

# Configure the AWS provider for a secondary region
provider "aws" {
  region = "us-east-2" # Set the AWS region to US East (Ohio)
  alias  = "useast2"   # Use an alias to differentiate this provider configuration from the primary one
}

# Configure the AWS Cloud Control (awscc) provider
provider "awscc" {
  region = "us-east-1" # Set the AWS Cloud Control region to US East (N. Virginia)
}

