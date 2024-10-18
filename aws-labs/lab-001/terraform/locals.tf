locals {
  ################################################################################
  # EC2 Instance
  ################################################################################

  #  instance configs
  recent            = true
  ami_owner         = "amazon"
  ami_filter_name   = "name"
  ami_filter_values = ["al2023-ami-2023.*-x86_64"]

  #  key-pair configs
  key_name   = var.key_name
  filename  = "tfkey" #"${path.module}/tfkey.pem"

  # Use variable if provided, otherwise use the default tags
  tags = var.tags != null ? var.tags : {
    Name        = "lab-001"
    prjects = "aws-labs"
    deployment  = "terraform"
    Environment = "Dev"
    Author      = "Lenon"
  }



  ################################################################################
  # VPC and Subnet
  ################################################################################
  vpc_cidr_block = coalesce("172.16.0.0/16", var.vpc_cidr_block)

  subnet_cidr_block = coalesce("172.16.10.0/24", var.subnet_cidr_block)

  region = coalesce("us-east-1a", data.aws_region.current.name)



  ################################################################################
  # storage
  ################################################################################

# S3 state config
  # bucket = coalesce("tfstate-lab-001", var.bucket)
  # status = "Enabled"

# aws_dynamodb_table config
  # name           = "app-state"
  # read_capacity  = 1
  # write_capacity = 1
  # hash_key       = "LockID"

  # attribute_name = "LockID"
  # attribute_type = "S"

  }