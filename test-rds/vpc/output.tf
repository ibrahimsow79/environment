
output "public_subnet_a_id" {
  value = aws_subnet.public_subnet_a.id
}

output "public_subnet_b_id" {
  value = aws_subnet.public_subnet_b.id
}

output "private_subnet_a_id" {
  value = aws_subnet.private_subnet_a.id
}

output "private_subnet_b_id" {
  value = aws_subnet.private_subnet_b.id
}

output "sg_appidecide_id" {
  value = aws_security_group.sg_appidecide.id
}

output "sg_sqlclient_id" {
  value = aws_security_group.sg_sqlclient.id
}
output "sg_db_idecide_id" {
  value = aws_security_group.sg_db_idecide.id
}
