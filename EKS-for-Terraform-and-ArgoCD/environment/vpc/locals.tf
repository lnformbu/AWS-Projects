locals {
  name   = var.environment_name
  region = data.aws_region.current.id

  vpc_cidr       = var.vpc_cidr
  num_of_subnets = min(length(data.aws_availability_zones.available.names), 3)
  azs            = slice(data.aws_availability_zones.available.names, 0, local.num_of_subnets)

  tags = {
    Blueprint  = local.name
    Purpose    = "Self-study"
    Author     = "Lenon Nformbui"
    GithubRepo = "https://github.com/lnformbu/AWS-Projects/tree/main/EKS-for-Terraform-and-ArgoCD"
  }
}