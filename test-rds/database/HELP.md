## AWS API References

- [RDS] [Amazon RDS] (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [Route53] [Amazon Route53] (https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)

## Examples

Input variables.tf (JSON):

```json
variable "db_name" {
  default = "digitalpressdb"
}
variable "db_instance_class" {
  default = "db.t2.medium"
}
variable "db_engine" {
  default = "mysql"
}
variable "db_username" {
  default = "administrator"
}
variable "db_password" {
  default = "@@DB_LOGIN_PASSWORD@@"
}
variable "db_allocated_storage" {
  default = "20"
}
variable "engine_version" {
  default = "8.0.15"
}
variable "backup_retention_period" {
  default = "7"
}
variable "backup_window" {
  default = "07:00-09:00"
}
variable "db_multi_az" {
  default = false
}
variable "allow_major_version_upgrade" {
  default = false
}
variable "auto_minor_version_upgrade"{
  default = false
}
variable "copy_tags_to_snapshot" {
  default = true
}
# true if oat & prod
variable "deletion_protection" {
  default = true
}
variable "storage_type" {
  default = "gp2"
}
variable "storage_encrypted"{
  default =true
}

variable "maintenance_window" {
  default ="fri:01:30-fri:02:00"
}
variable "ttl" {
  default = 300
}
variable "allow_overwrite" {
  default = false
}
variable "type" {
  default = "CNAME"
}
variable "zone_id" {
  default = "CZINUQC130J"
}







```

Terraform code:

```hcl-terraform
module "vpc" {
  source = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-vpc"
  [...]
}
module "db" {
  source                                                  = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-rds?ref=1.0.0"
  db_allocated_storage                                    = var.db_allocated_storage
  db_engine                                               = var.db_engine
  engine_version                                          = var.engine_version
  db_instance_class                                       = var.db_instance_class
  db_instance_name                                        = "${var.project}-${var.env}-rds"
  db_name                                                 = var.db_name
  username                                                = var.db_username
  password                                                = var.db_password
  skip_final_snapshot                                     = false
  storage_encrypted                                       = var.storage_encrypted
  backup_retention_period                                 = var.backup_retention_period
  backup_window                                           = var.backup_window
  db_subnet_group                                         = module.rds-subnet-group.subnet_group_name
  project                                                 = var.project
  env                                                     = var.env
  db_security_group                                       = [module.sg-rds.sg_id]
  multi_az                                                = var.db_multi_az
  Autoday                                                 = var.Autoday
  Autostop                                                = var.Autostop
  Autostart                                               = var.Autostart
  copy_tags_to_snapshot                                   = var.copy_tags_to_snapshot
  deletion_protection                                     = var.deletion_protection
  storage_type                                            = var.storage_type
  maintenance_window                                      = var.maintenance_window
  auto_minor_version_upgrade                              = var.auto_minor_version_upgrade
  allow_major_version_upgrade                             = var.allow_major_version_upgrade
  allow_overwrite                                         = var.allow_overwrite
  ttl                                                     = var.ttl
  type                                                    = var.type
  zone_id                                                 = var.zone_id
}

```
