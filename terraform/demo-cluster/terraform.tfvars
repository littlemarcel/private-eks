aws_region = "us-east-2"
vpc_id     = "vpc-0563e434cb6749f22"
private_subnet_ids_list = [
  "subnet-02726afab18226705",
  "subnet-0e8f6ebd06f927020",
  "subnet-0ad3056b0b9e4c50a",
]
clusters_prefix              = "demo"
eks_version                  = "1.28"
eks_node_group_desired_size  = "1"
eks_node_group_min_size      = "1"
eks_node_group_max_size      = "3"
eks_node_group_ami_type      = "BOTTLEROCKET_x86_64"
eks_node_group_instance_type = "t3.medium"
common_tags                  = {}
