resource "aws_internet_gateway" "igw" {
  count  = length(var.public_subnets_list) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.clusters_name_prefix}-igw"
      ManagedBy = "terraform"
    }
  )
}
