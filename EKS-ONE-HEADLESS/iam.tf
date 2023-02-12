module "eks_iam_role_cluster" {
  source       = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role?ref=2.3.0"
  name         = "${var.project}-cluster-role"
  project_name = var.project
  region       = var.region
  stack_name   = upper(var.env)
  principals   = ["eks.amazonaws.com"]
  tags = {
    Name    = "${var.project}-cluster-role"
    Project = "${var.project}"
    Env     = "${var.env}"
  }
}

module "eks_iam_role_worker" {
  source       = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role?ref=2.3.0"
  name         = "${var.project}-worker-role"
  project_name = var.project
  region       = var.region
  stack_name   = upper(var.env)
  principals   = ["ec2.amazonaws.com"]
  tags = {
    Name    = "${var.project}-worker-role"
    Project = "${var.project}"
    Env     = "${var.env}"
  }
}

resource "aws_iam_role" "eks_iam_role_addon" {
  name               = "${var.project}-addon-role"
  assume_role_policy = data.aws_iam_policy_document.irsa_assume_role[0].json

  inline_policy {}
  tags = {
    Name    = "${var.project}-addon-role"
    project = "${var.project}"
    env     = "${var.env}"
  }
}

# module "eks_iam_role_addon" {
#   source       = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role?ref=2.3.0"
#   name         = "${var.project}-addon-role"
#   project_name = var.project
#   region       = var.region
#   stack_name   = upper(var.env)
#   principals   = ["ec2.amazonaws.com", "eks.amazonaws.com"]
#   tags = {
#     Name    = "${var.project}-addon-role"
#     Project = "${var.project}"
#     Env     = "${var.env}"
#   }
# }

module "eks_iam_role_cluster-attachement1" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role-policy-attachement?ref=v1.3.6"
  role_name  = module.eks_iam_role_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

module "eks_iam_role_cluster-attachement2" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role-policy-attachement?ref=v1.3.6"
  role_name  = module.eks_iam_role_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

module "node_AmazonEKSWorkerNodePolicy" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role-policy-attachement?ref=v1.3.6"
  role_name  = module.eks_iam_role_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

module "addon_AmazonEKS_CNI_Policy" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role-policy-attachement?ref=v1.3.6"
  role_name  = module.eks_iam_role_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
module "node_AmazonEKS_CNI_Policy" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role-policy-attachement?ref=v1.3.6"
  role_name  = resource.aws_iam_role.eks_iam_role_addon.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
module "node_AmazonEC2ContainerRegistryReadOnly" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role-policy-attachement?ref=v1.3.6"
  role_name  = module.eks_iam_role_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

module "node_AmazonSSM" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-iam-role-policy-attachement?ref=v1.3.6"
  role_name  = module.eks_iam_role_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}