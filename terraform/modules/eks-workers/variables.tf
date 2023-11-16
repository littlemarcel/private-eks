variable "eks_private_subnets_list" {
  type = list(string)
}

variable "cluster_full_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "eks_oidc_arn" {
  type = string
}

variable "eks_oidc_url" {
  type = string
}

variable "eks_cluster_sg_id" {
  type = string
}

variable "eks_node_group_desired_size" {
  type = string
}

variable "eks_node_group_min_size" {
  type = string
}

variable "eks_node_group_max_size" {
  type = string
}

variable "eks_node_group_instance_type" {
  type = string
}

variable "eks_node_group_ami_type" {
  type = string
}

variable "cluster_autoscaler_sa_name" {
  type = string
  default = "cluster-autoscaler-controller-sa"
}

variable "cluster_autoscaler_sa_namespace" {
  type = string
  default = "kube-system"
}

variable "efs_csi_controller_sa_name" {
  type = string
  default = "efs-csi-controller-sa"
}

variable "efs_csi_controller_sa_namespace" {
  type = string
  default = "kube-system"
}

variable "ebs_csi_controller_sa_name" {
  type = string
  default = "ebs-csi-controller-sa"
}

variable "ebs_csi_controller_sa_namespace" {
  type = string
  default = "kube-system"
}

variable "common_tags" {
  type = map(string)
}
