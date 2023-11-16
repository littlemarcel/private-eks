aws_region = "us-east-2"
vpc_id     = "vpc-015eba777c049e8ad"
private_subnet_ids_list = [
  "subnet-07f7d76e316cb4c9f",
  "subnet-09204875c76260ff9",
  "subnet-0eb32e2e2050b4325",
]
clusters_prefix              = "demo"
eks_version                  = "1.28"
eks_node_group_desired_size  = "1"
eks_node_group_min_size      = "1"
eks_node_group_max_size      = "3"
eks_node_group_ami_type      = "BOTTLEROCKET_x86_64"
eks_node_group_instance_type = "t3.medium"
common_tags                  = {}
