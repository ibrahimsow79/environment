module "eks_node_groupe" {
  source = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-eks-node-group?ref=1.0.0"
  name   = "${var.project}-${var.env}-eks-node-group"

  # Required
  cluster_name  = module.eks_cluster.cluster_name
  node_role_arn = module.eks_iam_role_worker.arn
  subnet_ids    = values(local.private_subnets).*.subnet_id

  # Optional
  capacity_type  = var.capacity_type
  disk_size      = var.use_custom_launch_template ? null : var.disk_size
  instance_types = null
  labels         = var.labels

  # scaling_config
  min_size     = var.min_size
  max_size     = var.max_size
  desired_size = var.desired_size

  # launch-template
  launch_template_name  = "${var.project}-${var.env}-launch-template"
  image_id              = var.image_id
  instance_type         = var.instance_type
  iam_instance_profile  = var.iam_instance_profile
  block_device_mappings = var.block_device_mappings
  key_name              = module.keypair.key_name
  user_data             = try(local.platform[var.platform].user_data, null)
  tag_specifications = {
    instance = {
      resource_type = "instance"
      tags = {
        Name    = "${var.project}-${var.env}-eks-node-group"
        project = "${var.project}"
        env     = "${var.env}"
      }
    }
  }

  # remote_access
  remote_access = var.remote_access

  # update_config
  update_config = var.update_config

  # taints
  taints = var.taints

  # timeouts
  timeouts = var.node_timeouts

  # tags
  tags = var.tags
  depends_on = [
    module.eks_iam_role_worker
  ]
}