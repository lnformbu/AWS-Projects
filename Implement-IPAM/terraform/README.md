
- [Terraform Configuration](#terraform-configuration)
    - [Requirements](#requirements)
    - [Providers](#providers)
    - [Modules](#modules)
    - [Resources](#resources)
    - [Inputs](#inputs)
    - [Outputs](#outputs)

    

# Terraform Configuration. 

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.73.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 1.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.0 |
| <a name="provider_aws.useast2"></a> [aws.useast2](#provider\_aws.useast2) | 5.75.0 |
| <a name="provider_awscc"></a> [awscc](#provider\_awscc) | 1.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc.useast1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc.useast2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [awscc_ec2_ipam.main](https://registry.terraform.io/providers/hashicorp/awscc/latest/docs/resources/ec2_ipam) | resource |
| [awscc_ec2_ipam_pool.root](https://registry.terraform.io/providers/hashicorp/awscc/latest/docs/resources/ec2_ipam_pool) | resource |
| [awscc_ec2_ipam_pool.useast1](https://registry.terraform.io/providers/hashicorp/awscc/latest/docs/resources/ec2_ipam_pool) | resource |
| [awscc_ec2_ipam_pool.useast2](https://registry.terraform.io/providers/hashicorp/awscc/latest/docs/resources/ec2_ipam_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | The Amazon Machine Image (AMI) to use | `string` | `"ami-12345678"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to use | `string` | `"t2.micro"` | no |

## Outputs

No outputs.
