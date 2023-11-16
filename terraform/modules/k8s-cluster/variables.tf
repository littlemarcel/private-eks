variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cluster_full_name" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "private_subnet_ids_list" {
  type = list(string)
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

variable "common_tags" {
  type = map(string)
}
