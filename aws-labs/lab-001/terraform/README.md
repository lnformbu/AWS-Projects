## Table of Contents

1. [Note](#note)
2. [Requirements](#requirements)
3. [Providers](#providers)
4. [Modules](#modules)
5. [Resources](#resources)
6. [Inputs](#inputs)
7. [Outputs](#outputs)


## NOTE :
- key pair will not be saved to local machine when using terraform cloud as backend
- Available option to save it to an S3 bucket.
- I have the [TFLint Ruleset](https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/README.md) for terraform-provider-aws installed for run tflint. 


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.66, < 5.67.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.66.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [local_file.main](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.main](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | (String) Name of the algorithm to use when generating the private key. Currently-supported values are: `RSA`, `ECDSA`, `ED25519`. | `string` | `"RSA"` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | (Optional) AMI to use for the instance. Required unless launch\_template is specified<br/>   and the Launch Template specifes an AMI. If an AMI is specified in the Launch Template, <br/>   setting ami will override the AMI specified in the Launch Template. | `string` | `"ami-0ddc798b3f1a5117e"` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | (Optional) Whether to associate a public IP address with an instance in a VPC. | `bool` | `null` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | (Optional, Forces new resource) Name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length. | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (Optional) The type of instance to start | `string` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | (Optional) The name for the key pair. If neither key\_name nor key\_name\_prefix is <br/>   provided, Terraform will create a unique key name using the prefix `terraform-` | `string` | `null` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | (Required) The public key material. | `string` | `""` | no |
| <a name="input_rsa_bits"></a> [rsa\_bits](#input\_rsa\_bits) | (Optional) When algorithm is RSA, the size of the generated RSA key, in bits (default: 2048). | `number` | `null` | no |
| <a name="input_subnet_cidr_block"></a> [subnet\_cidr\_block](#input\_subnet\_cidr\_block) | (Optional) The IPv4 CIDR block for the subnet. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Name of tag | <pre>object({<br/>    Name       = string<br/>    deployment = string<br/>  })</pre> | `null` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | (Optional) The IPv4 CIDR block for the VPC. | `string` | `2048` | no |

## Outputs

No outputs.


