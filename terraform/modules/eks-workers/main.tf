resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_full_name
  node_group_name = "${var.cluster_full_name}-node-group"
  node_role_arn   = aws_iam_role.eks_worker_node_role.arn
  subnet_ids      = var.eks_private_subnets_list

  scaling_config {
    desired_size = var.eks_node_group_desired_size
    min_size     = var.eks_node_group_min_size
    max_size     = var.eks_node_group_max_size

  }
  instance_types = [var.eks_node_group_instance_type]
  ami_type       = var.eks_node_group_ami_type

  tags = merge(
    var.common_tags,
    {
      Name                                                 = "${var.cluster_full_name}-node-group"
      "k8s.io/cluster-autoscaler/${var.cluster_full_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"                  = "true"
      ManagedBy                                            = "terraform"
    }
  )
}
