data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "tls_certificate" "certificate" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
