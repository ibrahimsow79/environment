variable "aws_region" {
  description = "Region for the VPC"
  default     = "eu-west-1"
}

variable "aws_az_a" {
  description = "Availablity Zone a"
  default     = "eu-west-1a"
}

variable "aws_az_b" {
  description = "Availability Zone b"
  default     = "eu-west-1b"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.60.0.0/16"
}

# CIDR Block Notation of the Public Subnets
variable "public_subnet_cidr_a" {
  description = "CIDR for the public subnet"
  default     = "10.60.10.0/24"
}

variable "public_subnet_cidr_b" {
  description = "CIDR for the public subnet"
  default     = "10.60.20.0/24"
}

#CIDR Block Notation of the Private Subnets
variable "private_subnet_cidr_a" {
  description = "CIDR for the private subnet"
  default     = "10.60.30.0/24"
}

variable "private_subnet_cidr_b" {
  description = "CIDR for the public subnet"
  default     = "10.60.40.0/24"
}

variable "key_path" {
  description = "SSH Public Key path"
  default     = "/home/isow12/.ssh/id_rsa.pub"
  #  default = "C:\\Users\\i.sow\\.ssh\\id_rsa.pub"
}

variable "windows_key_path" {
  default = ".ssh/win.pem"
}

variable "env" {
  description = "environnement : prod, dev, int,rec"
  default     = "dev"
}

variable "my_credentials" {
  description = " Credentials being used to connect to AWS"
  type        = list(any)
  default     = ["/home/isow12/.aws/credentials"]
}

variable "my_profile" {
  description = " profile being used to connect to AWS"
  default     = "claranet-sandbox-bu-rmp"
}

# ================== APPIDECIDE VM
variable "private_ip_appidecide" {
  description = "Private IP address of appidecide VM"
  default     = "10.60.10.10"
}


variable "private_ip_appidecide-b" {
  description = "Private IP address of appidecide VM"
  default     = "10.60.20.10"
}

variable "ami_appidecide" {
  description = "Amazon Linux AMI"
  default     = "ami-0d71ea30463e0ff8d"
}

variable "instance_type_appidecide" {
  description = "Type d'instance à utiliser"
  default     = "t3.micro"
}

#======================== SQLCLIENT VM     ==============================

variable "private_ip_sqlclient" {
  description = "private ip for sqlclient"
  default     = "10.60.40.20"
}

variable "instance_type_sqlclient" {
  description = "Instance Type"
  default     = "t3a.small"
}

variable "ami_sqlclient" {
  description = "Amazon Linux AMI"
  default     = "ami-0d71ea30463e0ff8d"
}

variable "name_sqlclient" {
  description = "Nom de la VM"
  default     = "ec2-topic-leader-bo"
}

# ================================================= Database=========================================

variable "allocated_storage_space" {
  description = "Disk space allocated for the database"
  default     = "20"
}

variable "storage_type" {
  description = "type of storage to be used for the database"
  default     = "gp2"
}

variable "engine" {
  description = "type of engine Postgre, mysql, Oracle, ...."
  default     = "mysql"
}

variable "engine_version" {
  description = "engine version to be used for the database"
  default     = "8.0.28"
}

variable "instance_class" {
  description = "instance class for the database"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  default     = "dbtopicleader"
}

variable "name" {
  description = "Name"
  default     = "topic-leader-db"
}

variable "username" {
  description = "user to be created "
  default     = "administrator"
}

variable "password" {
  description = "Password to be used"
  default     = "oracle4u"
}

/*
variable "db_subnet_group" {
  description = "DB Subnet group to be used by the DB"
  default = ""
}
*/
variable "db_security_group" {
  description = "Security Group to be used for the database"
  default     = ""
}

variable "db_identifier" {
  description = "DB identifier"
  default     = "topicleaderdb"
}

