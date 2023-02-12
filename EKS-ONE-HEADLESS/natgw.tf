module "aws_natgw" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-natgw?ref=1.0.0"
  count      = length(var.natgws)
  eip_id     = module.aws_eip.*.eip_id[count.index]
  subnet_id  = lookup(local.subnet_ids, "subnet-${var.project}-${var.env}-${lookup(var.natgws[count.index], "natgw_availability_zone")}-${lookup(var.natgws[count.index], "natgw_subnet_name")}")
  natgw_name = lookup(var.natgws[count.index], "natgw_name")
  project    = var.project
  env        = var.env
}
module "aws_eip" {
  source = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-eip?ref=1.0.0"
  count  = length(var.natgws)
}

