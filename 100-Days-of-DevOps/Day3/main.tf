############################################
# create VPC and Subnet
############################################

resource "aws_vpc" "Day2" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-Day2"
  }
}


resource "aws_subnet" "Day2" {
  vpc_id            = aws_vpc.Day2.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-Day2"
  }
  depends_on = [
    aws_vpc.Day2
  ]
}


############################################
# Create the keypair and Public key
############################################

resource "aws_key_pair" "pemkey" {
  key_name   = "deployer-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#save the key to local machine
resource "local_file" "foo" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}


#####################
# fetch ami
#####################

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

############################################
# Create the Instance
############################################

resource "aws_instance" "Day2" {
  ami               = data.aws_ami.amzn-linux-2023-ami.id
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.Day2.id
  get_password_data = false

  cpu_options {
    core_count       = 2
    threads_per_core = 2
  }

  tags = {
    Name = "tf-Day2"
  }
  depends_on = [
    aws_subnet.Day2,
    data.aws_ami.amzn-linux-2023-ami
  ]
}