variable "environment_name" {
  description = "The name of the environments Infrastructure stack used for cluster and vpc"
  type        = string
  default     = "eks-lenon-testlab"
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

