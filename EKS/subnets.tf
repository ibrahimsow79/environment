module "subnets" {
  source                  = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-subnet?ref=1.3.6"
  vpc_id                  = module.aws_vpc.vpc_id
  count                   = length(var.subnets)
  availability_zone       = lookup(var.subnets[count.index], "subnet_availability_zone")
  map_public_ip_on_launch = lookup(var.subnets[count.index], "subnet_public_ip")
  name                    = "subnet-${var.project}-${var.env}-${lookup(var.subnets[count.index], "subnet_availability_zone")}-${lookup(var.subnets[count.index], "subnet_name")}"
  cidr_block              = lookup(var.subnets[count.index], "subnet_cidr_block")
  project_name            = var.project
  stack_name              = upper(var.env)
  tags = {
    Name                                                 = "subnet-${var.project}-${var.env}-${lookup(var.subnets[count.index], "subnet_availability_zone")}-${lookup(var.subnets[count.index], "subnet_name")}"
    project                                              = var.project
    env                                                  = var.env
    "kubernetes.io/cluster/one-headless-dev-eks-cluster" = "owned"

  }
}