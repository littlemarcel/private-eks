resource "aws_network_acl" "private_subnets_acl" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    rule_no  = 1
    protocol = "-1"
    action   = "allow"
    cidr_block = var.eks_vpc_block
    to_port    = 0
    from_port  = 0
  }

  egress {
    rule_no    = 1
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    to_port    = 0
    from_port  = 0
  }

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.clusters_name_prefix}-nacl-private-subnets",
      ManagedBy = "terraform"
    }
  )
}

resource "aws_network_acl" "public_subnets_acl" {
  count  = length(var.public_subnets_list) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  ingress {
    rule_no    = 1
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    to_port    = 0
    from_port  = 0
  }

  egress {
    rule_no    = 1
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    to_port    = 0
    from_port  = 0
  }

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.clusters_name_prefix}-nacl-public-subnets"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_network_acl_association" "private_subnets_acl_association" {
  count          = length(aws_subnet.eks_private_subnets)
  network_acl_id = aws_network_acl.private_subnets_acl.id
  subnet_id      = aws_subnet.eks_private_subnets[count.index].id
}

resource "aws_network_acl_association" "public_subnets_acl_association" {
  count          = length(aws_subnet.public_subnets)
  network_acl_id = aws_network_acl.public_subnets_acl[0].id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}
