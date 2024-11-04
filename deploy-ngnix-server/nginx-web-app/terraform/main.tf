# This resource creates an EC2 instance running an NGINX web server.
resource "aws_instance" "nginx" {
  instance_type          = "t2.micro"                       # Specifies the instance type as 't2.micro', which is cost-effective and suitable for small workloads.
  ami                    = "ami-0866a3c8686eaeeba"          # The Amazon Machine Image (AMI) ID used to launch the instance. This should correspond to a compatible AMI in the specified region.
  user_data              = file("userdata.tpl")             # A script file (`userdata.tpl`) that is executed upon instance boot, usually for installing software and initial configuration.
  vpc_security_group_ids = [aws_security_group.demo_sg.id]  # Associates the instance with the specified security group to control inbound and outbound traffic.
  key_name               = data.aws_key_pair.nginx.key_name # The name of the existing SSH key pair for secure SSH access to the instance.

  tags = {
    Name = "nginx" # Tags help identify and organize resources, setting the Name tag for easy identification.
  }
}

# This data block fetches information about an existing key pair in the AWS account.
data "aws_key_pair" "nginx" {
  key_name = "demo" # The key pair name must match an existing key pair in your AWS account. This allows secure access to the EC2 instance.
}

# This resource creates a default VPC if one is not already present. 
# It is a logical network for launching and managing resources within AWS.
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default-VPC" # Tags the VPC for easy identification in the AWS console.
  }
}

# This resource defines a security group to control access to the EC2 instance.
resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"                           # The name of the security group.
  description = "allow ssh on 22 & http on port 80" # Describes the purpose of the security group.
  vpc_id      = aws_default_vpc.default.id          # Associates the security group with the default VPC.

  # Inbound rule to allow SSH access on port 22 from any IP address.
  ingress {
    from_port   = 22            # Start of the port range (SSH).
    to_port     = 22            # End of the port range (SSH).
    protocol    = "tcp"         # Protocol type (TCP).
    cidr_blocks = ["0.0.0.0/0"] # Allows access from any IP address. Replace with a specific CIDR block for better security.
  }

  # Inbound rule to allow HTTP access on port 80 from any IP address.
  ingress {
    from_port   = 80            # Start of the port range (HTTP).
    to_port     = 80            # End of the port range (HTTP).
    protocol    = "tcp"         # Protocol type (TCP).
    cidr_blocks = ["0.0.0.0/0"] # Allows access from any IP address.
  }

  # Outbound rule to allow all traffic (commonly set for unrestricted outbound access).
  egress {
    from_port   = 0             # Start of the port range (all ports).
    to_port     = 0             # End of the port range (all ports).
    protocol    = "-1"          # Protocol type (-1 means all protocols).
    cidr_blocks = ["0.0.0.0/0"] # Allows outbound traffic to any IP address.
  }

  tags = {
    Name = "nginx-sg" # Tags the security group for identification.
  }
}
