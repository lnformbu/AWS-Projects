## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.33.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 20.8 |
| <a name="module_gitops_bridge_bootstrap"></a> [gitops\_bridge\_bootstrap](#module\_gitops\_bridge\_bootstrap) | gitops-bridge-dev/gitops-bridge/helm | 0.1.0 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.argocd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_role.eks_admin_role_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_iam_session_context.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_session_context) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons"></a> [addons](#input\_addons) | This is a list of EKS add-ons that you want to enable in the cluster. <br/>  Add-ons provide additional functionality and integrations for your EKS cluster. | `any` | <pre>{<br/>  "enable_aws_argocd": false,<br/>  "enable_aws_load_balancer_controller": false,<br/>  "enable_karpenter": true<br/>}</pre> | no |
| <a name="input_authentication_mode"></a> [authentication\_mode](#input\_authentication\_mode) | The authentication mode for the cluster. Valid values are CONFIG\_MAP, API or API\_AND\_CONFIG\_MAP | `string` | `"API_AND_CONFIG_MAP"` | no |
| <a name="input_eks_admin_role_name"></a> [eks\_admin\_role\_name](#input\_eks\_admin\_role\_name) | This variable represents the name of the IAM role that will be granted <br/>  administrative privileges within the EKS cluster. | `string` | `"WSParticipantRole"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | This version of Kubernetes to be installed or updated in the EKS cluster.. | `string` | `"1.31"` | no |
| <a name="input_project_context_prefix"></a> [project\_context\_prefix](#input\_project\_context\_prefix) | Prefix for project | `string` | `"eks-blueprints-workshop"` | no |
| <a name="input_secret_name_git_data_addons"></a> [secret\_name\_git\_data\_addons](#input\_secret\_name\_git\_data\_addons) | Secret name for Git data addons | `string` | `"eks-blueprints-workshop-gitops-addons"` | no |
| <a name="input_secret_name_git_data_platform"></a> [secret\_name\_git\_data\_platform](#input\_secret\_name\_git\_data\_platform) | Secret name for Git data platform | `string` | `"eks-blueprints-workshop-gitops-platform"` | no |
| <a name="input_secret_name_git_data_workloads"></a> [secret\_name\_git\_data\_workloads](#input\_secret\_name\_git\_data\_workloads) | Secret name for Git data workloads | `string` | `"eks-blueprints-workshop-gitops-workloads"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Cluster certificate\_authority\_data |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Cluster endpoint |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name |
| <a name="output_cluster_node_security_group_id"></a> [cluster\_node\_security\_group\_id](#output\_cluster\_node\_security\_group\_id) | Cluster node security group |
| <a name="output_cluster_region"></a> [cluster\_region](#output\_cluster\_region) | Cluster region |
| <a name="output_configure_kubectl"></a> [configure\_kubectl](#output\_configure\_kubectl) | Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig |
