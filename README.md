# Initial setup for a Private EKS cluster

### 1. TF State storage and lock
Two sets of S3 buckets and DynamoDB tables are required: 
the first set is for state locking and storing the state of VPC (shared-resources), 
while the second set is dedicated to state locking and storing the state of EKS clusters' resources.
* adjust shared-state/terraform.tfvars
* cd shared-state
* terraform init
* terraform apply

### 2. VPC and networking resources creation
After creating the S3 buckets and DynamoDB tables, one should setup the VPC, 
including its private subnets, route tables, and VPC endpoints.
* adjust s3 backend and state lock config in shared-resources/config.tf 
using the resources created in Section 1.
* adjust shared-resource/terraform.tfvars by specifying the desired cidr blocks, 
aws region and clusters' name prefix
* cd shared-resources
* terraform init
* terraform apply

### 3. EKS cluster creation
* adjust s3 backend and state lock config in shared-resources/config.tf
  using the resources created in Section 1.
* adjust demo-cluster/terraform.tfvars using the subnet ids created in Section 2.
* Execute ./create-cluster.sh <cluster-name>