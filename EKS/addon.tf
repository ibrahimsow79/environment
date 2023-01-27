module "add-on" {
  source                   = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-eks-addon?ref=1.0.0"
  count                    = length(local.eks_addons)
  project_name             = var.project
  region                   = var.region
  stack_name               = upper(var.env)
  cluster_name             = module.eks_cluster.cluster_name
  addon_name               = lookup(local.eks_addons[count.index], "addon_name")
  addon_version            = lookup(local.eks_addons[count.index], "version")
  resolve_conflicts        = var.resolve_conflicts
  configuration_values     = lookup(local.eks_addons[count.index], "addon_name") == "coredns" ? var.configuration_values_coredns : var.configuration_values
  service_account_role_arn = lookup(local.eks_addons[count.index], "addon_name") == "vpc-cni" ? resource.aws_iam_role.eks_iam_role_addon.arn : module.eks_iam_role_worker.arn
  addon_timeouts           = var.addon_timeouts
  tags = {
    Name    = "${var.project}-eks-addon"
    Project = "${var.project}"
    Env     = "${var.env}"
  }
  depends_on = [
    resource.aws_iam_role.eks_iam_role_addon,
  ]
}