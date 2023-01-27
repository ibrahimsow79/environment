module "aws_vpc" {
  source       = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-vpc?ref=1.3.6"
  name         = "vpc.${var.env}.chanel"
  cidr         = var.vpc_cidr
  project_name = var.project
  stack_name   = upper(var.env)
  region       = var.region
}