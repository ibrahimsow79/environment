# GIS Terraform module
 
## Why?
CHANEL Azure Cloud Governance defines a set of pratices and requirements to be enforced over the deployed ressources.
This module will help to maintain and ensure that this set defined from GBL Governance definition is made available on all deployed ressources.
 
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | "~> 4"  |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_route53_record.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name                                                                                                                      | Description | Type | Default      | Required |
|---------------------------------------------------------------------------------------------------------------------------|-------------|------|--------------|:--------:|
| <a name="input_Autoday"></a> [Autoday](#input\_Autoday)                                                                   | n/a | `any` | `null`       | no |
| <a name="input_Autostart"></a> [Autostart](#input\_Autostart)                                                             | n/a | `any` | `null`       | no |
| <a name="input_Autostop"></a> [Autostop](#input\_Autostop)                                                                | n/a | `any` | `null`       | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | n/a | `bool` | `false`      | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade)    | n/a | `bool` | `true`       | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period)               | n/a | `number` | `30`         | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window)                                               | n/a | `string` | `"04:00-06:00"` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot)                   | n/a | `bool` | `true`       | no |
| <a name="input_db_allocated_storage"></a> [db\_allocated\_storage](#input\_db\_allocated\_storage)                        | n/a | `any` | n/a          | yes |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine)                                                           | n/a | `any` | n/a          | yes |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class)                                 | n/a | `any` | n/a          | yes |
| <a name="input_db_instance_name"></a> [db\_instance\_name](#input\_db\_instance\_name)                                    | n/a | `any` | n/a          | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name)                                                                 | n/a | `any` | n/a          | yes |
| <a name="input_db_security_group"></a> [db\_security\_group](#input\_db\_security\_group)                                 | n/a | `list(string)` | n/a          | yes |
| <a name="input_db_subnet_group"></a> [db\_subnet\_group](#input\_db\_subnet\_group)                                       | n/a | `any` | n/a          | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection)                             | n/a | `bool` | `true`       | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version)                                            | n/a | `any` | n/a          | yes |
| <a name="input_env"></a> [env](#input\_env)                                                                               | n/a | `any` | n/a          | yes |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier)         | n/a | `string` | `"null"`     | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window)                                | n/a | `any` | n/a          | yes |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az)                                                              | n/a | `bool` | `false`      | no |
| <a name="input_password"></a> [password](#input\_password)                                                                | n/a | `any` | n/a          | yes |
| <a name="input_project"></a> [project](#input\_project)                                                                   | n/a | `any` | n/a          | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot)                           | n/a | `bool` | `false`      | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted)                                   | n/a | `bool` | `true`       | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type)                                                  | n/a | `string` | `"gp2"`      | no |
| <a name="input_username"></a> [username](#input\_username)                                                                | n/a | `any` | n/a          | yes |
| <a name="input_allow_overwrite"></a> [allow_overwrite](#input\_allow_overwrite)                                                  | n/a | `bool` | `false`      | yes |
| <a name="input_type"></a> [type](#input\_type)                                                                        | n/a | `string` | `"CNAME"`    | yes |
| <a name="input_ttl"></a> [ttl](#input\_ttl)                                                                          | n/a | `number` | `300`        | yes |
| <a name="input_zone_id"></a> [zone_id](#input\_zone_id)                                                                | n/a | `string` | null         | yes |

## Outputs

| Name | Description               |
|------|---------------------------|
| <a name="output_rds-endpoint"></a> [rds-endpoint](#output\_rds-endpoint) | The database Endpoint     |
| <a name="output_rds-fqdn"></a> [rds-fqdn](#output\_rds-fqdn) | The database route53 FQDN |

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
