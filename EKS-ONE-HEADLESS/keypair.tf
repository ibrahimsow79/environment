module "ssh-rsa-key" {
  source      = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-tls-sshkey?ref=1.1.0"
  algorithm   = var.algorithm
  rsa_bits    = var.rsa_bits
  ecdsa_curve = var.ecdsa_curve
}
module "keypair" {
  source     = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-keypair?ref=1.0.0"
  key_name   = "${var.project}-${var.env}-instance"
  public_key = trimspace(module.ssh-rsa-key.public_key_openssh)
}