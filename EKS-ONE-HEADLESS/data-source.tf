data "aws_eks_addon_version" "eks_addon" {
  count              = length(var.eks_addons)
  addon_name         = element(var.eks_addons, count.index)
  kubernetes_version = var.cluster_version
}

data "cloudinit_config" "linux_eks_managed_node_group" {
  count = var.platform == "linux" && !var.enable_bootstrap_user_data && var.pre_bootstrap_user_data != "" ? 1 : 0

  base64_encode = true
  gzip          = false
  boundary      = "//"

  # Prepend to existing user data supplied by AWS EKS
  part {
    content_type = "text/x-shellscript"
    content      = var.pre_bootstrap_user_data
  }
}

data "tls_certificate" "this" {
  # Not available on outposts
  count = var.enable_irsa && !(length(var.outpost_config) > 0) ? 1 : 0

  url = module.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "irsa_assume_role" {
  count = var.enable_irsa ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [resource.aws_iam_openid_connect_provider.oidc_provider[0].arn]
    }

    condition {
      test     = var.irsa_assume_role_condition_test
      variable = "${resource.aws_iam_openid_connect_provider.oidc_provider[0].url}:sub"
      values   = [for sa in var.irsa_namespace_service_accounts : "system:serviceaccount:${sa}"]
    }

    # https://aws.amazon.com/premiumsupport/knowledge-center/eks-troubleshoot-oidc-and-irsa/?nc1=h_ls
    condition {
      test     = var.irsa_assume_role_condition_test
      variable = "${resource.aws_iam_openid_connect_provider.oidc_provider[0].url}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

data "aws_acm_certificate" "chanel_cert" {
  domain   = "*.chanel.com"
  statuses = ["ISSUED"]
}

# data "aws_acm_certificate" "lpl-cloud_cert" {
#   domain   = "*.lpl-cloud.com"
#   statuses = ["ISSUED"]
# }