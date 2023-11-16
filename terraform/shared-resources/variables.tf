variable "aws_region" {
  type = string
}

variable "vpc_block" {
  type = string
}

variable "clusters_name_prefix" {
  type = string
}

variable "private_subnets_list" {
  type = list(string)
}

variable "public_subnets_list" {
  type = list(string)
}
