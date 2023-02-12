module "secretsmanager_secret" {
  source      = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-secrets-manager-secret?ref=1.0.0"
  name        = "${var.project}-${var.env}_apac"
  description = "Used in the ${var.project} project"
  project     = var.project
  env         = var.env
}
module "secretsmanager_version" {
  source        = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-secrets-manager-version?ref=1.0.0"
  secret_id     = module.secretsmanager_secret.id
  secret_string = jsonencode({ "public_key" = "${module.ssh-rsa-key.public_key_openssh}", "private_key" = "${module.ssh-rsa-key.private_key_openssh}" })
}