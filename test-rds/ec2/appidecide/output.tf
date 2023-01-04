output "appidecide_ip" {
  value = aws_instance.appidecide.*.public_ip
}

output "appidecide_id" {
  value = aws_instance.appidecide.id
}
