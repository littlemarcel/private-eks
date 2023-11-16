resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.cluster_full_name}-cluster-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.cluster_full_name}-cluster-role"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_eks_identity_provider_config" "eks_oidc_config" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  oidc {
    identity_provider_config_name = "${var.cluster_full_name}-oidc-config"
    client_id                     = regex("/id/([A-Z0-9]+)$", aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer)[0]
    issuer_url                    = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  }

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.cluster_full_name}-oidc-config"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.certificate.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.cluster_full_name}-oidc-provider"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_iam_policy_attachment" "cluster_policy_attachment" {
  name       = "${var.cluster_full_name}-cluster-policy-attachement"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.eks_cluster_role.name]
}

resource "aws_iam_policy_attachment" "service_policy_attachment" {
  name       = "${var.cluster_full_name}-service-policy-attachement"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  roles      = [aws_iam_role.eks_cluster_role.name]
}
