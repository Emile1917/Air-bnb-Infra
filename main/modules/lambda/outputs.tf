output "lambda_function_arn" {
  value = aws_lambda_function.csv_formatter.arn
  description = "The ARN of the Lambda function"
}