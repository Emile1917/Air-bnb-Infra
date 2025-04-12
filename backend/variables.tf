

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "terraform-lock-table"
}


variable "hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
  default     = "LockID"
}

variable "attribute" {
  description = "The attribute to be used for the resource"
  type        = list(object({
   name = string
    type = string
  }))
  default     = [
    {
      name = "LockID"
      type = "S"
    }
  ]
  
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-state-bucket"
}