output "eks_cluster_vpc_id" {
  value = aws_vpc.vpc.id
}

output "eks_private_subnet_ids" {
  value = aws_subnet.eks_private_subnets.*.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets.*.id
}

output "eks_private_route_tables_ids" {
  value = aws_route_table.eks_private_route_tables.*.id
}

output "allow_all_sg_id" {
  value = aws_security_group.allow_all_sg.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
