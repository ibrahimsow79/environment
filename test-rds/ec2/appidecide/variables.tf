variable "ami" {
  description = "Amazon Linux AMI"
}

variable "private_ip" {
  description = "Private IP address of appidecide VM"
}

variable "key_path" {
  description = "SSH Public Key path"
  default     = "/home/isow12/.ssh/id_rsa.pub"
}

variable "sg_appidecide_id" {
  description = "Security Group of appidecide VM"
}

variable "public_subnet_id" {}

variable "private_subnet_id" {}

variable "instance_type" {
  description = "Instance Type"
}

variable "key_pair" {
  description = "Identifier of the key pair used to connect to root"
}
variable "env" {
  description = "environnement : prod, dev, int,rec"
}
variable "ebs_size" {
  default = "8"
}
variable "delete_on_termination" {
  default = true
}
