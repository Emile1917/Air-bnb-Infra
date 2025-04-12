output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
  description = "value of the lambda role ARN"
}

output "glue_crawler_role_arn" {
  value = aws_iam_role.glue_crawler_role.arn
  description = "value of the glue crawler role ARN"
  
}