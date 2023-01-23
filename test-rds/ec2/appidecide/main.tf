# Define appidecide VML inside the public subnet  a

resource "aws_instance" "appidecide" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.sg_appidecide_id]
  associate_public_ip_address = true
  private_ip                  = var.private_ip
  source_dest_check           = false
  iam_instance_profile        = "aws-s3-read-policy"
  user_data                   = file("ec2/appidecide/install.sh")

  root_block_device {
    volume_size           = var.ebs_size
    volume_type           = "gp3"
    delete_on_termination = var.delete_on_termination
  }

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = var.ebs_size
    volume_type           = "gp3"
    delete_on_termination = var.delete_on_termination
  }

  tags = {
    Name        = "ec2-topic-leader-fo"
    Environment = var.env
  }
}