output "dynamodb_table_id" {
  value = aws_dynamodb_table.dynamodb_table.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dynamodb_table.name
}
