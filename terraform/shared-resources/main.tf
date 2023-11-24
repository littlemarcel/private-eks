locals {
  common_tags = {}
}

module "vpc" {
  source                   = "../modules/vpc"
  aws_region               = var.aws_region
  eks_vpc_block            = var.vpc_block
  clusters_name_prefix     = var.clusters_name_prefix
  eks_private_subnets_list = var.private_subnets_list
  public_subnets_list      = var.public_subnets_list
  common_tags              = local.common_tags
}

module "endpoints" {
  source                  = "../modules/vpc-endpoints"
  private_subnet_ids_list = module.vpc.eks_private_subnet_ids
  private_rtb_ids_list = module.vpc.eks_private_route_tables_ids
  vpc_id               = module.vpc.vpc_id
  clusters_name_prefix = var.clusters_name_prefix
  gateway_endpoints_list = [
    "com.amazonaws.${var.aws_region}.s3"
  ]
  interface_endpoints_list = [
    // EKS worker nodes requirement. EBS CSI Storage driver will need it too.
    "com.amazonaws.${var.aws_region}.ec2",

    // VPC can connect to EKS control plane
    "com.amazonaws.${var.aws_region}.eks",

    // Cluster Autoscaling can adjust EKS Node group desired size
    "com.amazonaws.${var.aws_region}.autoscaling",

    // EKS nodes can communicate with ECR Api for image mgmt
    "com.amazonaws.${var.aws_region}.ecr.api",

    // Docker can pull images from ECR
    "com.amazonaws.${var.aws_region}.ecr.dkr",

    // EKS has access to S3 for storing logs and other operational data
    "com.amazonaws.${var.aws_region}.s3",

    // (Optional) Required if IAM Roles for Service Accounts (IRSA) will be used
    "com.amazonaws.${var.aws_region}.sts",

    // (Optional) May be used for sending logs from the cluster to CloudWatch
    "com.amazonaws.${var.aws_region}.logs",

    // (Optional) Required if ingress controller/s are needed
    "com.amazonaws.${var.aws_region}.elasticloadbalancing",

    // (Optional) Required if EFS Storage will be used
    "com.amazonaws.${var.aws_region}.elasticfilesystem"
  ]
  common_tags = local.common_tags
}

module "ecr" {
  source               = "../modules/ecr"
  clusters_name_prefix = var.clusters_name_prefix
}
