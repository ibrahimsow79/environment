
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}
output "vpc_id" {
  value = data.aws_vpc.my-vpc.id
}
output "vpc_arn" {
  value = data.aws_vpc.my-vpc.arn
}
output "public_subnet_a_id" {
  value = data.aws_subnets.public-subnet-a.ids
}
output "public_subnet_b_id" {
  value = data.aws_subnets.public-subnet-b.ids
}
output "private_subnet_a_id" {
  value = data.aws_subnets.private-subnet-a.ids
}
output "private_subnet_b_id" {
  value = data.aws_subnets.private-subnet-b.ids
}

output "instance_public_ip" {
  value = module.appidecide.appidecide_ip
}
output "instance_id" {
  value = module.appidecide.appidecide_id
}
/*
output "rds-endpoint" {
  value = module.db.rds-endpoint
}

output "rds-fqdn" {
  value = module.db.rds-fqdn
}
*/

/*
output "rds-endpoint-2" {
  value = module.db2.rds-endpoint
}
*/
