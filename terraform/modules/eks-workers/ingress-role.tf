resource "aws_iam_role" "ingress_controller_role" {
  name               = "${var.cluster_full_name}-ingress-controller-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "${var.eks_oidc_arn}"
      }
    }
  ]
}
POLICY
  tags = merge(
    var.common_tags,
    {
      Name      = "${var.cluster_full_name}-ingress-controller-role"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ingress_policy_attachment" {
  role       = aws_iam_role.ingress_controller_role.name
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
}
