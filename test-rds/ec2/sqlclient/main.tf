# Define the sqlclient inside public subnet 1
resource "aws_instance" "sqlclient" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.sg_sqlclient_id]
  source_dest_check           = false
  user_data                   = file("ec2/sqlclient/install.sh")
  iam_instance_profile        = "aws-s3-read-policy"
  private_ip                  = var.private_ip
  associate_public_ip_address = false

  root_block_device {
    volume_size           = var.ebs_size
    volume_type           = "gp3"
    delete_on_termination = var.delete_on_termination
  }

  tags = {
    Name          = var.name
    Environnement = var.env
  }
}
