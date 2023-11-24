output "efs_id" {
  value = aws_efs_file_system.efs.id
}

output "efs_csi_driver_role_arn" {
  value = aws_iam_role.efs_csi_driver_role.arn
}

output "ebs_csi_driver_role_arn" {
  value = aws_iam_role.ebs_csi_driver_role.arn
}

output "cluster_autoscaler_role_arn" {
  value = aws_iam_role.cluster_autoscaler_role.arn
}
