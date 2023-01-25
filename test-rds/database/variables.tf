
##########################################################      RDS Database Variables      ##########################################################

variable "db_allocated_storage" {
}
variable "allow_major_version_upgrade" {
  default = false
}
variable "auto_minor_version_upgrade" {
  default = true
}
variable "db_engine" {
}
variable "engine_version" {
}
variable "db_instance_class" {
}
variable "db_instance_name" {
}
variable "db_name" {
}
variable "skip_final_snapshot" {
  default = false
}
variable "final_snapshot_identifier" {
  default = "null"
}
variable "backup_retention_period" {
}
variable "backup_window" {
  default = "04:00-06:00"
}
variable "copy_tags_to_snapshot" {
  default = true
}
variable "deletion_protection" {
  default = true
}
variable "maintenance_window" {
}
variable "multi_az" {
  default = false
}
variable "storage_type" {
  default = "gp2"
}
variable "storage_encrypted" {
  default = true
}
variable "username" {
}
variable "password" {
}
variable "db_subnet_group" {
}
variable "project" {
}
variable "db_security_group" {
  type = list(string)
}
variable "env" {
}
variable "Autoday" {
  default = null
}
variable "Autostart" {
  default = null
}
variable "Autostop" {
  default = null
}
variable "apply_immediately" {
  default = false
}
variable "restore_to_point_in_time" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      restore_time                  = string
      source_db_instance_identifier = string
    }
  ))
  default = []
}

##########################################################      Route53 Variables      ##########################################################
variable "ttl" {
  description = "The TTL of the record"
  default     = 300
}
variable "allow_overwrite" {
  description = "Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments."
  default     = false
}
variable "type" {
  description = "(Required) The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT."
  default     = "CNAME"
}
variable "zone_id" {
  description = "The ID of the hosted zone to contain this record"
  default     = null
}
variable "dns_instance_name" {
  description = "DNS name"
  default     = null
}