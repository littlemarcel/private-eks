variable "clusters_name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "interface_endpoints_list" {
  type = list(string)
}

variable "gateway_endpoints_list" {
  type = list(string)
}

variable "private_subnet_ids_list" {
  type = list(string)
}

variable "private_rtb_ids_list" {
  type = list(string)
}

variable "common_tags" {
  type = map(string)
}
