## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.66, < 5.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.66.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc) | resource |
| [aws_instance.nginx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.demo_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_key_pair.nginx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/key_pair) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_instance_public_dns"></a> [aws\_instance\_public\_dns](#output\_aws\_instance\_public\_dns) | instance public doman name server |



<br>

## Main.tf
> Explanation:
- `AWS Instance Resource`: Configures an EC2 instance that uses the specified AMI and runs a user data script to set up NGINX.
- `Key Pair Data Source`: References an existing key pair named demo to ensure secure SSH access.
- `Default VPC Resource`: Ensures a VPC is available for the EC2 instance, facilitating network communication.
- `Security Group Resource`: Configures rules for incoming SSH and HTTP traffic and unrestricted outbound traffic for the instance.

> Security Notes:
- The `cidr_blocks = ["0.0.0.0/0"]` in the `ingress` rules allows traffic from any IP address, which is convenient for testing but poses a security risk in production. Replace `0.0.0.0/0` with a specific CIDR range to restrict access.
- Ensure the AMI ID and key pair exist in the specified AWS region to prevent errors during deployment.


## UserData.tpl. 
> Use the Appropriate Package Manager:
- `Debian/Ubuntu`: Uses apt (If apt isn't found, ensure it's installed, or use apt-get instead)
- `CentOS/RHEL`: Use yum
- `Fedora`: Use dnf
- `Amazon Linux`: Use yum or dnf

> Explanation:
- `sudo yum update -y`: Updates the package index.
- `sudo amazon-linux-extras install nginx1 -y`: Installs NGINX via the amazon-linux-extras repository, which is tailored for Amazon Linux.
- `sudo systemctl enable/start nginx`: Enables and starts the NGINX service.
- `sudo tee`: Safely writes the HTML content to `/usr/share/nginx/html/index.html` without needing redirection permissions.