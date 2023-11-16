resource "aws_security_group" "eks_cluster_sg" {
  name   = "${var.cluster_full_name}-cluster-sg"
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name                                             = "${var.cluster_full_name}-cluster-sg"
      "kubernetes.io/cluster/${var.cluster_full_name}" = "owned"
      ManagedBy                                        = "terraform"

    }
  )
}

resource "aws_security_group_rule" "allow_eks_cp_api" {
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_blocks       = [data.aws_vpc.vpc.cidr_block]
  type              = "ingress"
}
