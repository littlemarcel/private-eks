resource "aws_vpc" "vpc" {
  cidr_block = var.eks_vpc_block
  enable_dns_hostnames = true
  tags = merge(
    var.common_tags,
    {
      Name      = "${var.clusters_name_prefix}-vpc"
      ManagedBy = "terraform"
    }
  )
}


