resource "aws_efs_file_system" "efs" {
  throughput_mode = "elastic"

  tags = merge(
    var.common_tags,
    {
      Name                                             = "${var.cluster_full_name}-efs"
      "kubernetes.io/cluster/${var.cluster_full_name}" = "owned"
      ManagedBy                                        = "terraform"
    }
  )
}

resource "aws_efs_mount_target" "efs_mount_target" {
  for_each       = toset(var.eks_private_subnets_list)
  subnet_id      = each.value
  file_system_id = aws_efs_file_system.efs.id
}

resource "aws_security_group" "efs_sg" {
  name   = "${var.cluster_full_name}-efs-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name                                             = "${var.cluster_full_name}-efs-sg"
      "kubernetes.io/cluster/${var.cluster_full_name}" = "owned"
      ManagedBy                                        = "terraform"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "efs_allow_inbound" {
  from_port         = 2049
  to_port           = 2049
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.efs_sg.id
  cidr_ipv4         = data.aws_vpc.vpc.cidr_block

  tags = merge(
    var.common_tags,
    {
      Name                                             = "${var.cluster_full_name}-efs-sg-inbound-rule"
      "kubernetes.io/cluster/${var.cluster_full_name}" = "owned"
      ManagedBy                                        = "terraform"
    }
  )
}
