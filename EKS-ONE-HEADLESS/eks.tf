module "eks_cluster" {
  source                    = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-eks-cluster?ref=1.0.0"
  name                      = "${var.project}-${var.env}-eks-cluster"
  cluster_role              = module.eks_iam_role_cluster.arn
  cluster_version           = var.cluster_version
  cluster_enabled_log_types = var.cluster_enabled_log_types

  #vpc_config
  subnet_ids                            = module.subnets.*.subnet_id
  cluster_endpoint_private_access       = var.cluster_endpoint_private_access
  cluster_endpoint_public_access        = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs  = var.cluster_endpoint_public_access_cidrs
  cluster_security_group_id             = null
  cluster_additional_security_group_ids = var.cluster_additional_security_group_ids
  control_plane_subnet_ids              = var.control_plane_subnet_ids

  #kubernetes_network_config
  cluster_ip_family         = var.cluster_ip_family
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr
  cluster_service_ipv6_cidr = var.cluster_service_ipv6_cidr

  #outpost_config
  outpost_config = var.outpost_config

  #encryption_config
  cluster_encryption_config = var.cluster_encryption_config
  create_kms_key            = var.create_kms_key
  encryption_key_arn        = module.kms_key[0].arn

  #timeouts
  cluster_timeouts = var.cluster_timeouts

  #tags
  tags = {
    Name    = "${var.project}-eks-cluster"
    Project = "${var.project}"
    Env     = "${var.env}"
  }
  depends_on = [
    module.eks_iam_role_cluster
  ]
}