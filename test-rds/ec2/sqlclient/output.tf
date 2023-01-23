output "sqlclient_ip" {
  value = aws_instance.sqlclient.*.public_ip
}
