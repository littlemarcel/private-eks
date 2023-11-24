resource "aws_iam_role" "eks_worker_node_role" {
  name = "${var.cluster_full_name}-eks-workers-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.cluster_full_name}-eks-workers-role"
      ManagedBy = "terraform"
    }
  )
}

//Grants permissions for EKS worker nodes to make calls to AWS services required to run pods
resource "aws_iam_role_policy_attachment" "eks_worker_node" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

//Grants permissions required by the Amazon VPC CNI plugin to manage network interfaces, IPs, and other networking resources.
resource "aws_iam_role_policy_attachment" "eks_cni" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

// Grants read-only access to Amazon ECR. This is necessary for worker nodes to pull container images.
resource "aws_iam_role_policy_attachment" "ecr_read_only" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

// For Demo purposes only. Should be removed in a prod environment.
resource "aws_iam_role_policy_attachment" "ecr_full_access" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

// Allows CloudWatch agent to collect and push metrics
resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

