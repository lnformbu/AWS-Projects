
data "aws_region" "current" {}

data "aws_ami" "main" {
  most_recent = local.recent
  owners      = [local.ami_owner]

  filter {
    name   = local.ami_filter_name
    values = local.ami_filter_values
  }
}



################################################################################
# EC2 Instance
################################################################################

resource "aws_instance" "main" {
  ami                         = coalesce(var.ami, data.aws_ami.main.id)
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.main.id
  associate_public_ip_address = var.associate_public_ip_address

  tags = local.tags

  depends_on = [
    aws_subnet.main,
    aws_key_pair.main
  ]
}

# Creates key pair
resource "aws_key_pair" "main" {
  key_name   = coalesce("lab-001-key", local.key_name)
  public_key = tls_private_key.main.public_key_openssh
  tags       = local.tags

  depends_on = [
    tls_private_key.main
  ]
}


# RSA key of size 4096 bits
resource "tls_private_key" "main" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}


# Saves the key to local machine
resource "local_file" "main" {
  content  = tls_private_key.main.private_key_pem
  filename = local.filename

  depends_on = [
    tls_private_key.main
  ]
}




################################################################################
# VPC and Subnet
################################################################################

resource "aws_vpc" "main" {
  cidr_block = local.vpc_cidr_block
  tags       = local.tags
}


resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.subnet_cidr_block
  availability_zone = local.region

  tags = local.tags

  depends_on = [
    aws_vpc.main
  ]
}


# ################################################################################
# # S3 bucket - store start file
# ################################################################################

# resource "aws_s3_bucket" "tf_state" {
#   bucket = local.bucket

#   lifecycle {
#     prevent_destroy = true
#   }

#   tags = {
#     Name        = "tf_state=lab-001"
#     Deployment  = "terraform"
#     Environment = "Dev"
#     Author      = "Lenon"
#   }
# }

# resource "aws_s3_bucket_versioning" "tf_state" {
#   bucket = aws_s3_bucket.tf_state.id

#   versioning_configuration {
#     status = local.status
#   }

# }

# resource "aws_dynamodb_table" "tf_state_lock" {
#   name           = local.name
#   read_capacity  = local.read_capacity
#   write_capacity = local.write_capacity
#   hash_key       = local.hash_key

#   attribute {
#     name = local.attribute_name
#     type = local.attribute_type
#   }

#   tags = {
#     Name        = "tf_state=lab-001"
#     Deployment  = "terraform"
#     Environment = "Dev"
#     Author      = "Lenon"
#   }
# }
