resource "aws_iam_role" "cluster_autoscaler_role" {
  name               = "${var.cluster_full_name}-cluster-autoscaler-role"
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
          "${replace(var.eks_oidc_url, "https://", "")}:sub": "system:serviceaccount:${var.cluster_autoscaler_sa_namespace}:${var.cluster_autoscaler_sa_name}"
        }
      }
    }
  ]
}
POLICY
  tags = merge(
    var.common_tags,
    {
      Name      = "${var.cluster_full_name}-cluster-autoscaler-role"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeScalingActivities",
        "ec2:DescribeInstanceTypes",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup"
      ],
      "Resource": ["*"]
    }
  ]
}
POLICY
  tags = merge(
    var.common_tags,
    {
      Name      = "${var.cluster_full_name}-cluster-autoscaler-policy"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler_policy_attachment" {
  role       = aws_iam_role.cluster_autoscaler_role.name
  policy_arn = aws_iam_policy.cluster_autoscaler_policy.arn
}
