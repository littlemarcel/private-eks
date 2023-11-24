output "eks_oidc_url" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "eks_oidc_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}

output "eks_api_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_api_ca" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_cluster_sg_id" {
  value = aws_security_group.eks_cluster_sg.id
}
