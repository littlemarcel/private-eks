module "eks_node_group" {
  source                       = "../eks-workers"
  aws_region                   = var.aws_region
  vpc_id                       = var.vpc_id
  cluster_full_name            = var.cluster_full_name
  eks_private_subnets_list     = var.private_subnet_ids_list
  eks_cluster_sg_id            = module.eks_cp.eks_cluster_sg_id
  eks_oidc_arn                 = module.eks_cp.eks_oidc_arn
  eks_oidc_url                 = module.eks_cp.eks_oidc_url
  eks_node_group_ami_type      = var.eks_node_group_ami_type
  eks_node_group_desired_size  = var.eks_node_group_desired_size
  eks_node_group_instance_type = var.eks_node_group_instance_type
  eks_node_group_max_size      = var.eks_node_group_max_size
  eks_node_group_min_size      = var.eks_node_group_min_size
  common_tags                  = var.common_tags
}
