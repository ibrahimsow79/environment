module "kms_key" {
  source       = "git@ssh.dev.azure.com:v3/lpl-sources/Terraform/mod-aws-kms-key?ref=1.3.0"
  count        = var.create_kms_key ? 1 : 0
  activated    = true
  key_rotation = true
  policy_statements = [
    {
      Action     = ["kms:*"]
      Effect     = "Allow"
      Principals = [format("arn:aws:iam::%s:root", var.aws_account_id)]
      Resource   = ["*"]
    }
  ]
  tags = {
    Name    = "${var.project}-kms-key"
    Project = "${var.project}"
    Env     = "${var.env}"
  }
}