output "clusters_state_lock_table_name" {
  value = module.tf-clusters-state-lock.dynamodb_table_name
}

output "clusters_vpc_state_lock_table_name" {
  value = module.tf-vpc-state-lock.dynamodb_table_name
}

output "clusters_state_s3_bucket_name" {
  value = module.tf-clusters-tf-state-s3-bucket.s3_bucket_name
}

output "vpc_state_s3_bucket_name" {
  value = module.tf-vpc-tf-state-s3-bucket.s3_bucket_name
}
