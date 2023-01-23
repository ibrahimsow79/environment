output "rds-endpoint" {
  value = aws_db_instance.default.endpoint
}
output "rds-fqdn" {
  value = one(aws_route53_record.dbrecord[*].fqdn)
}