variable "bucket_arn" {
  description = "The ARN of the S3 bucket"
  type        = string
  
}

variable "lambda_role_name" {
  description = "The name of the IAM role for the Lambda function"
  type        = string
  default     = "csv_formater_lambda_role"
}

variable "lambda_policy_name" {
  description = "The name of the IAM policy for the Lambda function"
  type        = string
  default     = "csv_formater_lambda_policy"  
  
}

variable "cloudwatch_arn" {
  description = "The name of the IAM role for CloudWatch"
  type        = string
  default     = "arn:aws:logs:*:*:*"
  
}

variable "sqs_arn" {
  description = "The ARN of the SQS queue"
  type        = string
  default     = "arn:aws:sqs:us-east-1:123456789012:my-queue"
  
}

variable "sns_arn" {
  description = "The ARN of the SNS topic"
  type        = string
  default     = "arn:aws:sns:us-east-1:123456789012:my-topic"
  
}


variable "role_version" {
  description = "The version of the IAM role policy"
  type        = string
  default     = "2012-10-17"
  
}

variable "statements" {
  description = "The statements for the IAM role policy"
  type        = list(object({
    Sid       = string
    Effect    = string
    Action    = list(string)
    Resource  = list(string)
  }))
  default     = [
        {

            Effect = "Allow",
            Action = [
                "s3:GetObject",
                "s3:PutObject"
            ],
            Resource = [
                "arn:aws:s3:::test471112644131/*"
            ]
        }
    
]
}

variable "aws_glue_managed_policy_arn" {
  description = "The AWS Glue managed policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  
}

variable "aws_glue_crawler_role_name" {
  description = "The name of the IAM role for the Glue crawler"
  type        = string
  default     = "glue-crawler-role"
  
}

variable "aws_glue_crawler_policy_name" {
  description = "The name of the IAM policy for the Glue crawler"
  type        = string
  default     = "glue-crawler-policy"
  
}