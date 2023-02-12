locals {
  private_subnets = { for subnet in module.subnets.* : subnet.subnet_name => subnet if subnet.subnet_public_ip == false }
  public_subnets  = { for subnet in module.subnets.* : subnet.subnet_name => subnet if subnet.subnet_public_ip == true }
  subnet_ids      = zipmap(module.subnets.*.subnet_name, module.subnets.*.subnet_id)
  eks_addons      = data.aws_eks_addon_version.eks_addon


  int_linux_default_user_data = var.platform == "linux" && var.enable_bootstrap_user_data ? templatefile("${path.module}/linux_user_data.tpl",
    {
      enable_bootstrap_user_data = var.enable_bootstrap_user_data
      # Required to bootstrap node
      cluster_name        = module.eks_cluster.cluster_name
      cluster_endpoint    = module.eks_cluster.endpoint
      cluster_auth_base64 = module.eks_cluster.certificate_authority[0].data
      # Optional
      cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr != null ? var.cluster_service_ipv4_cidr : ""
      bootstrap_extra_args      = var.bootstrap_extra_args
      pre_bootstrap_user_data   = var.pre_bootstrap_user_data
      post_bootstrap_user_data  = var.post_bootstrap_user_data
  }) : ""
  platform = {
    bottlerocket = {
      user_data = var.platform == "bottlerocket" && (var.enable_bootstrap_user_data || var.bootstrap_extra_args != "") ? templatefile("${path.module}/bottlerocket_user_data.tpl",
        {
          enable_bootstrap_user_data = var.enable_bootstrap_user_data
          # Required to bootstrap node
          cluster_name        = module.eks_cluster.cluster_name
          cluster_endpoint    = module.eks_cluster.endpoint
          cluster_auth_base64 = module.eks_cluster.certificate_authority[0].data
          # Optional - is appended if using EKS managed node group without custom AMI
          # cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr # Bottlerocket pulls this automatically https://github.com/bottlerocket-os/bottlerocket/issues/1866
          bootstrap_extra_args = var.bootstrap_extra_args
      }) : ""
    }
    linux = {
      user_data = try(data.cloudinit_config.linux_eks_managed_node_group[0].rendered, local.int_linux_default_user_data)

    }
  }
}