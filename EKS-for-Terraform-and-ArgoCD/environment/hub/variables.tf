
variable "kubernetes_version" {
  description = <<EOF
  This version of Kubernetes to be installed or updated in the EKS cluster..
  EOF
  type        = string
  default     = "1.31"
}

variable "eks_admin_role_name" {
  description = <<EOF
  This variable represents the name of the IAM role that will be granted 
  administrative privileges within the EKS cluster.
  EOF
  type        = string
  default     = "WSParticipantRole"
}

variable "addons" {
  description = <<EOF
  This is a list of EKS add-ons that you want to enable in the cluster. 
  Add-ons provide additional functionality and integrations for your EKS cluster.
  EOF
  type        = any
  default = {
    enable_aws_load_balancer_controller = false
    enable_aws_argocd                   = false
    enable_karpenter                    = true
  }
}

variable "project_context_prefix" {
  description = "Prefix for project"
  type        = string
  default     = "eks-blueprints-workshop"
}

variable "authentication_mode" {
  description = "The authentication mode for the cluster. Valid values are CONFIG_MAP, API or API_AND_CONFIG_MAP"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "secret_name_git_data_addons" {
  description = "Secret name for Git data addons"
  type        = string
  default     = "eks-blueprints-workshop-gitops-addons"
}

variable "secret_name_git_data_platform" {
  description = "Secret name for Git data platform"
  type        = string
  default     = "eks-blueprints-workshop-gitops-platform"
}

variable "secret_name_git_data_workloads" {
  description = "Secret name for Git data workloads"
  type        = string
  default     = "eks-blueprints-workshop-gitops-workloads"
}

