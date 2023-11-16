variable "clusters_name_prefix" {
  type = string
}

variable "table_name" {
  type = string
}

variable "partition_key_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
