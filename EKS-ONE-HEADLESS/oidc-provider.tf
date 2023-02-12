resource "aws_iam_openid_connect_provider" "oidc_provider" {
  # Not available on outposts
  count = var.enable_irsa && !(length(var.outpost_config) > 0) ? 1 : 0

  client_id_list  = var.openid_connect_audiences
  thumbprint_list = concat(data.tls_certificate.this[0].certificates[*].sha1_fingerprint, var.custom_oidc_thumbprints)
  url             = module.eks_cluster.identity[0].oidc[0].issuer

  tags = {
    Name    = "${var.project}-eks-irsa"
    project = "${var.project}"
    env     = "${var.env}"
  }
}