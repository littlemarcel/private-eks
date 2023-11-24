resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.table_name
  hash_key       = var.partition_key_name
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = var.partition_key_name
    type = "S"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.clusters_name_prefix}-${var.table_name}-table"
      ManagedBy = "terraform"
    }
  )
}


