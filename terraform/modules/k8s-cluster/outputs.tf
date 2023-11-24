output "eks_api_endpoint" {
  value = module.eks_cp.eks_api_endpoint
}

output "eks_oidc_url" {
  value = module.eks_cp.eks_oidc_url
}

output "eks_api_ca" {
  value = module.eks_cp.eks_api_ca
}

output "efs_id" {
  value = module.eks_node_group.efs_id
}

output "efs_csi_driver_role_arn" {
  value = module.eks_node_group.efs_csi_driver_role_arn
}

output "ebs_csi_driver_role_arn" {
  value = module.eks_node_group.ebs_csi_driver_role_arn
}

output "cluster_autoscaler_role_arn" {
  value = module.eks_node_group.cluster_autoscaler_role_arn
}
