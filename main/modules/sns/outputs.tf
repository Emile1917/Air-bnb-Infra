output "topic_arn" {
  value = aws_sns_topic.lambda_failure_topic.arn
  description = "The ARN of the SNS topic"
  
}