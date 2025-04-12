variable "s3_bucket_names" {
  description = "The names of the S3 buckets"
  type        = list(string)
  default     = ["airbnb-project-main","airbnb-project-athena-requests"]
  
}