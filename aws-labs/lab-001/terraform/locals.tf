locals {
  ################################################################################
  # EC2 Instance
  ################################################################################

  #  instance configs
  recent            = true
  ami_owner         = "amazon"
  ami_filter_name   = "name"
  ami_filter_values = ["al2023-ami-2023.*-x86_64"]

  instance_type               = "t2.micro"
  associate_public_ip_address = true
  ami                         = coalesce(var.ami, data.aws_ami.main.id) # fall back to the data.aws_ami value when none is provided

  #  key-pair configs
  key_name   = coalesce("lab-001", var.key_name)
  public_key = coalesce(tls_private_key.main.public_key_openssh, var.public_key)

  #  RSA key Config
  algorithm = coalesce("RSA", var.algorithm)
  rsa_bits  = coalesce(2048, var.rsa_bits)


  filename = "tfkey"

  # Use variable if provided, otherwise use the default tags
  tags = var.tags != null ? var.tags : {
    Name        = "lab-001"
    deployment  = "terraform"
    Environment = "Dev"
    Author      = "Lenon"
  }


  # S3 state config
  bucket = coalesce("tfstate-lab-001", var.bucket)

  status = "Enabled"


  name           = "app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute_name = "LockID"
  attribute_type = "S"

  ################################################################################
  # VPC and Subnet
  ################################################################################
  vpc_cidr_block = coalesce("172.16.0.0/16", var.vpc_cidr_block)

  subnet_cidr_block = coalesce("172.16.10.0/24", var.subnet_cidr_block)

  region = coalesce("us-east-1a", data.aws_region.current.name)


}

