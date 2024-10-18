



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

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}


resource "aws_instance" "Day2" {
  ami                         = data.aws_ami.amzn-linux-2023-ami.id
  associate_public_ip_address = true
  instance_type               = "c6a.2xlarge"
  subnet_id                   = aws_subnet.Day2.id
  get_password_data           = false
  key_name = "demo"

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