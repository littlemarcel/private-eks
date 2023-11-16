module "eks_cp" {
  source                  = "../eks-cp"
  vpc_id                  = var.vpc_id
  cluster_full_name       = var.cluster_full_name
  eks_version             = var.eks_version
  private_subnet_ids_list = var.private_subnet_ids_list
  common_tags             = var.common_tags
}
