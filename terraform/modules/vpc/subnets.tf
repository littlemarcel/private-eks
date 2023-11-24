resource "aws_subnet" "eks_private_subnets" {
  count             = length(var.eks_private_subnets_list)
  cidr_block        = var.eks_private_subnets_list[count.index]
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  tags = merge(
    var.common_tags,
    {
      Name = "${var.clusters_name_prefix}-${data.aws_availability_zones.azs.names[count.index]}-eks-private-subnet"
      // Ingress controller will spin up NLBs in subnets that have this tag
      "kubernetes.io/role/internal-elb" = "1"
      ManagedBy                         = "terraform"
    }
  )
}

// Used by the jump host. Only for demo purposes.
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets_list)
  cidr_block        = var.public_subnets_list[count.index]
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = merge(
    var.common_tags,
    {
      "Name"    = "${var.clusters_name_prefix}-${data.aws_availability_zones.azs.names[count.index]}-public-subnet"
      ManagedBy = "terraform"
    }
  )
}
