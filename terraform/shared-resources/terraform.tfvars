aws_region           = "us-east-2"
clusters_name_prefix = "demo"
vpc_block            = "10.20.0.0/16"
private_subnets_list = [
  "10.20.0.0/19",
  "10.20.32.0/19",
  "10.20.64.0/19"
]

public_subnets_list = [
  "10.20.160.0/19"
]
