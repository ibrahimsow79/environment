# Building the environment for i-decide application. Both Dev ad Prod envrionments are very similar.
# Define AWS as our provider
provider "aws" {
  region = var.aws_region
  // shared_credentials_files = var.my_credentials
  // profile                  = var.my_profile
  default_tags {
    tags = {
      Location = "Paris"
      Client   = "Claranet"
      backup   = "Yes"
      owner    = "ibrahim.sow@fr.clara.net"

    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49"
    }
  }
  //  backend "s3" {
  //    bucket = "s3-topic-leader-backup-recovery"
  //    key    = "infrastucture/main/terraform.tfstate"
  //    region = "eu-west-1"
  //  }
  required_version = "~>1.3"
}


data "aws_caller_identity" "current" {}

data "aws_iam_role" "iam-read-s3" {
  name = "aws-s3-read-policy"
}

# Ai rajouté les lignes pour variabilser les "availability zone" dans le script terraform
data "aws_availability_zones" "available" {
}

data "aws_vpc" "my-vpc" {
  tags = {
    Name = "vpc-idecide"
  }
}

data "aws_subnets" "public-subnet-a" {
  // vpc_id = data.aws_vpc.my-vpc.id
  tags = {
    Name = "Public Subnet A"
  }
}

data "aws_subnets" "public-subnet-b" {
  // vpc_id = data.aws_vpc.my-vpc.id
  tags = {
    Name = "Public Subnet B"
  }
}


data "aws_subnets" "private-subnet-a" {
  // vpc_id = data.aws_vpc.my-vpc.id
  tags = {
    Name = "Private subnet A"
  }
}

data "aws_subnets" "private-subnet-b" {
  // vpc_id = data.aws_vpc.my-vpc.id
  tags = {
    Name = "Private subnet B"
  }

}
// # Define SSH key pair for our instances

resource "aws_key_pair" "default" {
  key_name   = "vpc_keypair_isow"
  public_key = file(var.key_path)
}

// Creating an EC2 instance

module "appidecide" {
  source = "./ec2/appidecide/"

  ami               = var.ami_appidecide
  instance_type     = var.instance_type_appidecide
  sg_appidecide_id  = "sg-0b0f7374b92357d0d"
  public_subnet_id  = data.aws_subnets.public-subnet-a.ids[0]
  private_subnet_id = data.aws_subnets.private-subnet-a.ids[0]
  key_pair          = aws_key_pair.default.id
  private_ip        = var.private_ip_appidecide
  env               = var.env
}


// Creating the database


resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my_db_subnet_group"
  subnet_ids = [data.aws_subnets.private-subnet-a.ids[0], data.aws_subnets.private-subnet-b.ids[0]]
  tags = {
    Name = "My DB subnet group"
  }
}
/*
module "db" {
  source = "./database/"

  db_allocated_storage        = var.db_allocated_storage
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.allow_minor_version_upgrade
  db_engine                   = var.db_engine
  engine_version              = var.engine_version
  db_instance_class           = var.db_instance_class
  db_instance_name            = var.db_instance_name
  backup_window               = var.backup_window
  backup_retention_period     = var.backup_retention_period
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  deletion_protection         = var.deletion_protection
  db_name                     = var.db_name
  maintenance_window          = var.maintenance_window
  multi_az                    = var.multi_az
  username                    = var.username
  password                    = var.password
  storage_type                = var.storage_type
  storage_encrypted           = var.storage_encrypted
  skip_final_snapshot         = var.skip_final_snapshot
  final_snapshot_identifier   = var.final_snapshot_identifier
  db_subnet_group             = aws_db_subnet_group.my_db_subnet_group.id
  db_security_group           = ["sg-04c8ab3a222929ae4"]
  apply_immediately           = var.apply_immediately
  env                         = var.env
  project                     = var.project
  zone_id                     = var.zone_id
  dns_instance_name           = var.dns_instance_name
}
*/
module "db2" {
  source = "./database/"

  db_allocated_storage        = var.db_allocated_storage
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.allow_minor_version_upgrade
  db_engine                   = var.db_engine
  engine_version              = var.engine_version
  db_instance_class           = var.db_instance_class
  db_instance_name            = "isowdb-restore"
  backup_window               = var.backup_window
  backup_retention_period     = var.backup_retention_period
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  deletion_protection         = var.deletion_protection
  db_name                     = null
  maintenance_window          = var.maintenance_window
  multi_az                    = var.multi_az
  username                    = var.username
  password                    = var.password
  storage_type                = var.storage_type
  storage_encrypted           = var.storage_encrypted
  skip_final_snapshot         = var.skip_final_snapshot
  final_snapshot_identifier   = var.final_snapshot_identifier
  db_subnet_group             = aws_db_subnet_group.my_db_subnet_group.id
  db_security_group           = ["sg-04c8ab3a222929ae4"]
  apply_immediately           = var.apply_immediately
  env                         = var.env
  project                     = var.project
  zone_id                     = var.zone_id
  dns_instance_name           = "isowdb-restore"
  restore_to_point_in_time = [{
    restore_time                  = "2023-01-23T12:00:00Z"
    source_db_instance_identifier = "myisowdb"
  }]
}