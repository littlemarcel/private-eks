resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_full_name
  version  = var.eks_version
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.private_subnet_ids_list
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
    endpoint_public_access  = false
    endpoint_private_access = true
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.cluster_full_name}-eks-cluster"
      ManagedBy = "terraform"
    }
  )
}
