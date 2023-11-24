output "eks_api_endpoint" {
  value = module.demo_cluster.eks_api_endpoint
}

output "eks_api_ca" {
  value = module.demo_cluster.eks_api_ca
}

output "eks_oidc_url" {
  value = module.demo_cluster.eks_oidc_url
}

output "efs_id" {
  value = module.demo_cluster.efs_id
}

output "efs_csi_driver_role_arn" {
  value = module.demo_cluster.efs_csi_driver_role_arn
}

output "ebs_csi_driver_role_arn" {
  value = module.demo_cluster.ebs_csi_driver_role_arn
}

output "cluster_autoscaler_role_arn" {
  value = module.demo_cluster.cluster_autoscaler_role_arn
}
