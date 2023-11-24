output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_private_subnets_id_list" {
  value = module.vpc.eks_private_subnet_ids
}

output "public_subnets_id_list" {
  value = module.vpc.public_subnet_ids
}
