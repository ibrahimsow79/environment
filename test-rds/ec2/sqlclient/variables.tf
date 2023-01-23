variable "ami" {
  description = "AMI ID to be used"
}

variable "sg_sqlclient_id" {
  description = "Security group to be used"
}

variable "instance_type" {
  description = "Instance Type"
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
}

variable "private_subnet_id" {
  description = "Private Subnet ID"
}


variable "key_pair" {
  description = "Identifier of the key pair used to connect to root"
}

variable "name" {
  description = "Name of the EC2 Instance"
}

variable "ebs_size" {
  default = "10"
}

variable "private_ip" {
  description = "Private IP to be used for this instance"
}

variable "script" {
  default = "ec2/sqlclient/install.sh"
}

variable "env" {
  description = "environnement : prod, dev, int,rec"
}
variable "delete_on_termination" {
  default = true
}

