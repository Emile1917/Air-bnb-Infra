variable "catalog_database_name" {
  description = "The name of the Glue catalog database"
  type        = string
  default     = "airbnb_catalog_db"
}


variable "crawler_name" {
  description = "The name of the Glue crawler"
  type        = string
  default     = "airbnb-crawler"
  
}

variable "crawler_role_arn" {
  description = "The arn of the IAM role for the Glue crawler"
  type        = string
  
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}


variable "custom_json_classifier_name" {
  description = "The name of the custom JSON classifier"
  type        = string
  default     = "custom_json_classifier"
  
}

variable "custom_csv_classifier_name" {
  description = "The name of the custom CSV classifier"
  type        = string
  default     = "custom_csv_classifier"
  
}
