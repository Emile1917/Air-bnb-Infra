variable "lambda_role_name" {
  description = "The name of the IAM role for the Lambda function"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "csv_formater_lambda"
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default     = "python3.13"
}

variable "lambda_file_name" {
  description = "The name of the Lambda file"
  type        = string
  default     = "lambda.py"
  
}

variable "lambda_memory_size" {
  description = "The memory size for the Lambda function"
  type        = number
  default     = 2048
}

variable "lambda_timeout" {
  description = "The timeout for the Lambda function"
  type        = number
  default     = 500
}

variable "ephemeral_storage_size" {
  description = "The ephemeral storage size for the Lambda function"
  type        = number
  default     = 2048
  
}

variable "lambda_layer_name" {
  description = "The name of the Lambda layer"
  type        = string
  default     = "pandas_layer"

}


variable "lambda_layer_begin_arn" {
  description = "The ARN of the Lambda layer for pandas"
  type        = string
  default     = "arn:aws:lambda"
}

variable "lambda_layer_region" {
  description = "The region of the Lambda layer"
  type        = string
  default     = "us-east-1"
  
}
variable "user_account_id" {
  description = "The AWS account ID of the user"
  type        = string
  default = "336392948345"
}


variable "lambda_layer_ending_arn" {
  description = "The ARN of the Lambda layer"
  type        = string
  default     = "layer:AWSSDKPandas-Python312:16"
  
}
variable "lambda_layer_filename" {
  description = "The filename of the Lambda layer"
  type        = string
  default     = "lambda_layer_payload.zip"
}

variable "trigger_bucket_name" {
  description = "The name of the S3 bucket to trigger the Lambda function"
  type        = string
}

variable "trigger_bucket_arn" {
  description = "The ARN of the S3 bucket to trigger the Lambda function"
  type        = string
}

variable "success_queue_arn" {
  description = "The ARN of the SQS queue for successful Lambda invocations"
  type        = string
}

variable "failure_topic_arn" {
  description = "The ARN of the SNS topic for failed Lambda invocations"
  type        = string
  
}