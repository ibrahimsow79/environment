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
  default     = "/home/ec2-user/.ssh/id_rsa.pub"
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

variable "db_allocated_storage" {
  description = "Disk space allocated for the database"
  default     = 20
}

variable "allow_major_version_upgrade" {
  description = "to allow majour version upgrade"
  default     = false
}

variable "allow_minor_version_upgrade" {
  description = "to allow majour version upgrade"
  default     = true
}

variable "db_engine" {
  description = "DB engine"
  default     = "mysql"
}


variable "engine_version" {
  description = "DB Engine version"
  default     = "8.0.28"
}

variable "db_instance_class" {
  description = "Instance classe"
  default     = "db.t2.medium"
}

variable "db_instance_name" {
  description = "DB Instance Name"
  default     = "myisowdb"
}

variable "backup_window" {
  description = "backup windows"
  default     = "07:00-09:00"
}

variable "backup_retention_period" {
  description = "rettention period for the backup"
  default     = 2
}

variable "copy_tags_to_snapshot" {
  description = "Do we copy tags  to snapshot"
  default     = true
}

variable "deletion_protection" {
  description = "to prevent accidental delete"
  default     = false
}

variable "db_name" {
  description = "Name of the databse"
  default     = "testdb"
}

variable "maintenance_window" {
  description = "time for the windows maintenance"
  default     = "fri:01:30-fri:02:00"
}

variable "multi_az" {
  description = "High available database"
  default     = false
}

variable "username" {
  description = "user to be created "
  default     = "administrator"
}

variable "password" {
  description = "Password to be used"
  default     = "oracle4u"
}


variable "storage_type" {
  description = "type of storage to be used for the database"
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "do we encryp the storage"
  default     = true
}

variable "skip_final_snapshot" {
  description = "Do we skip the final storage"
  default     = true
}

variable "final_snapshot_identifier" {
  description = "Name of the final snapshot"
  default     = "last-snapshot-testdb"
}

/*
variable "db_subnet_group" {
  description = "The DB subnet group used for this database"
}
*/
variable "apply_immediately" {
  description = "do we apply immediately the changes"
  default     = false
}

variable "project" {
  description = "Name of the project"
  default     = "claranet"
}

variable "zone_id" {
  description = "The ID of the hosted zone to contain this record"
  default     = "Z09634132HDPQBPOAO0D2"
}

variable "dns_instance_name" {
  description = "DNS name"
  default     = "isowdb"
}
