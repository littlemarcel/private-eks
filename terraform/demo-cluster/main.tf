module "demo_cluster" {
  source                       = "../modules/k8s-cluster"
  cluster_full_name            = "${var.clusters_prefix}-${terraform.workspace}"
  aws_region                   = var.aws_region
  vpc_id                       = var.vpc_id
  eks_version                  = var.eks_version
  private_subnet_ids_list      = var.private_subnet_ids_list
  eks_node_group_ami_type      = var.eks_node_group_ami_type
  eks_node_group_instance_type = var.eks_node_group_instance_type
  eks_node_group_desired_size  = var.eks_node_group_desired_size
  eks_node_group_min_size      = var.eks_node_group_min_size
  eks_node_group_max_size      = var.eks_node_group_max_size
  common_tags                  = var.common_tags
}
