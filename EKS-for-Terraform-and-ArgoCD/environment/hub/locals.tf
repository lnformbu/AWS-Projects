
# ############################################################################################################################
# # kubernetes
# #############################################################################################################################

locals {
  context_prefix  = var.project_context_prefix
  name            = "lenon-hub-cluster"
  region          = data.aws_region.current.id
  cluster_version = var.kubernetes_version
  tenant          = "tenant1"
  fleet_member    = "control-plane"

  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets

  authentication_mode = var.authentication_mode

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/lnformbu/AWS-Projects/tree/main/EKS-for-Terraform-and-ArgoCD#how-i-finally-mastered-kubernetes-infrastructure"
    author     = "Lenon-Nformbui"
    purpose    = "Test-lab"
  }


  # ############################################################################################################################
  # EKS Cluster
  # #############################################################################################################################

  # locals{
  argocd_namespace = "argocd"
  environment      = "control-plane"


}
