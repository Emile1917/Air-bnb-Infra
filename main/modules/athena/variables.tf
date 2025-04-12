variable "aws_athena_data_catalog_name" {
  description = "The name of the Athena data catalog"
  type        = string
  
}

variable "wg_name" {
  description = "The name of the Athena workgroup"
  type        = string
  default     = "airbnb_workgroup"
  
}

variable "athena_database_name" {
  description = "The name of the Athena database"
  type        = string
  default     = "airbnb_database"
  
}

variable "s3_output_bucket_name" {
  description = "The name of the S3 bucket for output"
  type        = string
}