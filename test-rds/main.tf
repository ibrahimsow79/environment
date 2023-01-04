# Building the environment for i-decide application. Both Dev ad Prod envrionments are very similar.
# Define AWS as our provider
provider "aws" {
  region                   = var.aws_region
  // shared_credentials_files = var.my_credentials
  // profile                  = var.my_profile
  default_tags {
    tags = {
      Location = "Paris"
      Client   = "Chanel"
      backup   = "Yes"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }
  //  backend "s3" {
  //    bucket = "s3-topic-leader-backup-recovery"
  //    key    = "infrastucture/main/terraform.tfstate"
  //    region = "eu-west-1"
  //  }
  required_version = ">= 0.12"
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

data "aws_subnet_ids" "public-subnet-a" {
  vpc_id = data.aws_vpc.my-vpc.id
  tags = {
      Name = "Public Subnet A"
  }
}

data "aws_subnet_ids" "public-subnet-b" {
  vpc_id = data.aws_vpc.my-vpc.id
  tags = {
      Name = "Public Subnet B"
  }
}


data "aws_subnet_ids" "private-subnet-a" {
  vpc_id = data.aws_vpc.my-vpc.id
  tags = {
      Name = "Private subnet A"
  }
}

data "aws_subnet_ids" "private-subnet-b" {
  vpc_id = data.aws_vpc.my-vpc.id
  tags = {
      Name = "Private subnet B"
  }
  
}

// Creating the database


resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my_db_subnet_group"
  subnet_ids = [data.aws_subnet_ids.private-subnet-a.ids, data.aws_subnet_ids.private-subnet-b.ids]
  tags = {
    Name = "My DB subnet group"
  }
}
/*
module "db" {
  source = "./database/"

  allocated_storage = var.allocated_storage_space
  storage_type      = var.storage_type
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  db_name           = var.db_name
  username          = var.username
  password          = var.password
  db_subnet_group   = aws_db_subnet_group.my_db_subnet_group.id
  db_security_group = module.vpc.sg_db_idecide_id
  env               = var.env
  name              = var.name
  db_identifier     = var.db_identifier
}
*/