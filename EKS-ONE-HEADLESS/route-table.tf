#Route Tables
module "route-table-public" {
  source           = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-route-table?ref=1.0.0"
  route_table_name = "${var.project}-${var.env}_public"
  vpc_id           = module.aws_vpc.vpc_id
  project          = var.project
  env              = var.env
}
module "route-table-private" {
  source           = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-route-table?ref=1.0.0"
  count            = length(var.natgws)
  route_table_name = "${var.project}-${var.env}_private"
  vpc_id           = module.aws_vpc.vpc_id
  project          = var.project
  env              = var.env
}

#Internet Route
module "internet-route" {
  source         = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-route?ref=1.0.0"
  route_table_id = module.route-table-public.route-table-id
  cidr_block     = var.open_cidr_block
  gw_id          = module.aws_vpc.gw_id
}

#NAT Route
module "nat-route" {
  source         = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-route-nat?ref=1.0.0"
  count          = length(var.natgws)
  route_table_id = module.route-table-private.*.route-table-id[count.index]
  cidr_block     = var.open_cidr_block
  nat_gw_id      = element(module.aws_natgw.*.natgw_id, count.index)
}

# Route table and subnet associations
module "route_table_association_public" {
  source         = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-route-table-association?ref=1.0.0"
  for_each       = local.public_subnets
  route_table_id = module.route-table-public.route-table-id
  subnet_id      = each.value.subnet_id
  depends_on     = [module.subnets]
}


module "route_table_association_private" {
  source         = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-route-table-association?ref=1.0.0"
  count          = length(local.private_subnets)
  route_table_id = module.route-table-private.*.route-table-id[count.index % length(var.natgws)]
  subnet_id      = element(values(local.private_subnets), count.index).subnet_id
  depends_on     = [module.subnets]
}
