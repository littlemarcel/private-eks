resource "aws_iam_role" "efs_csi_driver_role" {
  name               = "${var.cluster_full_name}-efs-csi-driver-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "${var.eks_oidc_arn}"
      },
      "Condition": {
        "StringEquals": {
          "${replace(var.eks_oidc_url, "https://", "")}:sub": "system:serviceaccount:${var.efs_csi_controller_sa_namespace}:${var.efs_csi_controller_sa_name}"
        }
      }
    }
  ]
}
POLICY
  tags = merge(
    var.common_tags,
    {
      Name      = "${var.cluster_full_name}-efs-csi-driver-role"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_iam_role_policy_attachment" "efs_csi_driver_policy_attachment" {
  role       = aws_iam_role.efs_csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}
