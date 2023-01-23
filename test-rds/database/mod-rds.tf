
##########################################################      RDS Instance      ##########################################################

resource "aws_db_instance" "default" {
  allocated_storage           = var.db_allocated_storage
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  engine                      = var.db_engine
  engine_version              = var.engine_version
  instance_class              = var.db_instance_class
  identifier                  = var.db_instance_name
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
  db_subnet_group_name        = var.db_subnet_group
  vpc_security_group_ids      = var.db_security_group
  apply_immediately           = var.apply_immediately
  dynamic "restore_to_point_in_time" {
    for_each = var.restore_to_point_in_time
    content {
      restore_time                  = restore_to_point_in_time.value["restore_time"]
      source_db_instance_identifier = restore_to_point_in_time.value["source_db_instance_identifier"]
    }
  }
  lifecycle {
    ignore_changes = [
      storage_encrypted
    ]
  }
  tags = {
    Name              = var.db_name
    project           = var.project
    env               = var.env
    db_security_group = "${var.project}-${var.env}"
    Autoday           = var.Autoday
    Autostop          = var.Autostop
    Autostart         = var.Autostart
  }
}

locals {
  # return var.createdns = 1 if var.zone_id is not null
  # return var.createdns = 0 if var.zone_id is null
  createdns         = try(length(var.zone_id), 0) > 0 ? 1 : 0
  dns_instance_name = try(length(var.zone_id), 0) > 0 ? var.dns_instance_name : var.db_instance_name
}


resource "aws_route53_record" "dbrecord" {

  count           = local.createdns
  name            = local.dns_instance_name
  type            = var.type
  ttl             = var.ttl
  allow_overwrite = var.allow_overwrite
  zone_id         = var.zone_id
  records         = [aws_db_instance.default.address, ]
}