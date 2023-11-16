locals {
  common_tags = {}
}

module "tf-clusters-state-lock" {
  source               = "../modules/dynamodb-table"
  clusters_name_prefix = var.clusters_name_prefix
  table_name           = "${var.clusters_name_prefix}-tf-state-lock-dynamodb"
  partition_key_name   = var.lock_id_name
  common_tags          = local.common_tags
}

module "tf-vpc-state-lock" {
  source               = "../modules/dynamodb-table"
  clusters_name_prefix = var.clusters_name_prefix
  table_name           = "${var.clusters_name_prefix}-tf-vpc-state-lock-dynamodb"
  partition_key_name   = var.lock_id_name
  common_tags          = local.common_tags
}

module "tf-clusters-tf-state-s3-bucket" {
  source               = "../modules/s3-bucket"
  clusters_name_prefix = var.clusters_name_prefix
  bucket_name          = "${var.clusters_name_prefix}-clusters-tf-state-s3-bucket"
  common_tags          = local.common_tags
}

module "tf-vpc-tf-state-s3-bucket" {
  source               = "../modules/s3-bucket"
  clusters_name_prefix = var.clusters_name_prefix
  bucket_name          = "${var.clusters_name_prefix}-vpc-tf-state-s3-bucket"
  common_tags          = local.common_tags
}

