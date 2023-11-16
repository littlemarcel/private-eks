resource "aws_route_table" "eks_private_route_tables" {
  count  = length(var.eks_private_subnets_list)
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.clusters_name_prefix}-${data.aws_availability_zones.azs.names[count.index]}-rtb-private"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_route_table_association" "eks_private_rt_association" {
  count          = length(var.eks_private_subnets_list)
  route_table_id = element(aws_route_table.eks_private_route_tables.*.id, count.index)
  subnet_id      = element(aws_subnet.eks_private_subnets.*.id, count.index)
}

resource "aws_route_table" "public_route_table" {
  count  = length(var.public_subnets_list) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.clusters_name_prefix}-${data.aws_availability_zones.azs.names[count.index]}-rtb-public"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_route" "public_route" {
  count                  = length(var.public_subnets_list) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(var.public_subnets_list)
  route_table_id = aws_route_table.public_route_table[0].id
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
}
