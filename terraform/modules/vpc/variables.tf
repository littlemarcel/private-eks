variable "aws_region" {
  type = string
}

variable "eks_vpc_block" {
  type = string
}

variable "clusters_name_prefix" {
  type = string
}

variable "eks_private_subnets_list" {
  type = list(string)
}

variable "public_subnets_list" {
  type = list(string)
}

variable "common_tags" {
  type = map(string)
}
