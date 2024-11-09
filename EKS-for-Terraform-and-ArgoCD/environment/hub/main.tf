
# #############################################################################################################################
# # kubernetes
# #############################################################################################################################


provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name, "--region", local.region]
  }
}




################################################################################
# EKS Cluster
################################################################################
#tfsec:ignore:aws-eks-enable-control-plane-logging
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"

  cluster_name                   = local.name
  cluster_version                = local.cluster_version
  cluster_endpoint_public_access = true

  authentication_mode = local.authentication_mode

  # Combine root account, current user/role and additional roles to be able to access the cluster KMS key - required for terraform updates
  kms_key_administrators = distinct(concat([
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"],
    [data.aws_iam_session_context.current.issuer_arn]
  ))

  enable_cluster_creator_admin_permissions = true
  access_entries = {
    # One access entry with a policy associated
    eks_admin = {
      principal_arn = data.aws_iam_role.eks_admin_role_name.arn
      policy_associations = {
        argocd = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  vpc_id     = local.vpc_id
  subnet_ids = local.private_subnets

  eks_managed_node_groups = {
    initial = {
      instance_types = ["t3.medium"]

      min_size     = 3
      max_size     = 10
      desired_size = 3

      taints = var.addons.enable_karpenter ? {
        dedicated = {
          key      = "CriticalAddonsOnly"
          operator = "Exists"
          effect   = "NO_SCHEDULE"
        }
      } : {}
    }
  }

  cluster_addons = {
    eks-pod-identity-agent = {
      most_recent = true
    }
    vpc-cni = {
      # Specify the VPC CNI addon should be deployed before compute to ensure
      # the addon is configured before data plane compute resources are created
      # See README for further details
      before_compute = true
      most_recent    = true # To ensure access to the latest settings provided
      configuration_values = jsonencode({
        env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }
  node_security_group_additional_rules = {
    # Allows Control Plane Nodes to talk to Worker nodes vpc cni metrics port
    vpc_cni_metrics_traffic = {
      description                   = "Cluster API to node 61678/tcp vpc cni metrics"
      protocol                      = "tcp"
      from_port                     = 61678
      to_port                       = 61678
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }
  node_security_group_tags = merge(local.tags, {
    # NOTE - if creating multiple security groups with this module, only tag the
    # security group that Karpenter should utilize with the following tag
    # (i.e. - at most, only one security group should have this tag in your account)
    "karpenter.sh/discovery" = local.name
  })
  tags = local.tags
}




# #############################################################################################################################
# # Install Argo CD with GitOps Bridge
# #############################################################################################################################



# provider "helm" {
#   kubernetes {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       # This requires the awscli to be installed locally where Terraform is executed
#       args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name, "--region", local.region]
#     }
#   }
# }


# resource "kubernetes_namespace" "argocd" {
#   metadata {
#     name = local.argocd_namespace
#   }
#   depends_on = [ module.eks ]
# }

# ################################################################################
# # GitOps Bridge: Bootstrap
# ################################################################################

# module "gitops_bridge_bootstrap" {
#   source = "gitops-bridge-dev/gitops-bridge/helm"
#   version = "0.1.0"
#   cluster = {
#     cluster_name = module.eks.cluster_name
#     environment  = local.environment
#     #enablemetadata metadata     = local.addons_metadata
#     #enablemetadata addons       = local.addons
#   }

#   # enableapps apps = local.argocd_apps
#   argocd = {
#     name = "argocd"
#     namespace        = local.argocd_namespace
#     chart_version    = "7.5.2"
#     values = [file("${path.module}/argocd-initial-values.yaml")]
#     timeout          = 600
#     create_namespace = false
#   }

#   depends_on = [ module.eks ]
# }



