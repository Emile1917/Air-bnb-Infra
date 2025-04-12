output "s3_bucket_name" {
  value = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_arn" {
  value = module.s3_bucket.s3_bucket_arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.basic-dynamodb-table.name
  
}

output "dynamodb_table_endpoint" {
  value = aws_dynamodb_table.basic-dynamodb-table.arn
  
}