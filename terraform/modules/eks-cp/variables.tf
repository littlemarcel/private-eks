variable "cluster_full_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "private_subnet_ids_list" {
  type = list(string)
}

variable "common_tags" {
  type = map(string)
}
