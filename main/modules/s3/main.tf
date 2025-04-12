

resource "random_string" "rs" {
  length = 10
  min_lower = 7
  min_numeric = 3
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "airbnb-project${random_string.rs.result}"
  acl    = "private"
  
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
  acceleration_status = "Enabled"
  server_side_encryption_configuration = {
    rule = [
      {
        apply_server_side_encryption_by_default = {
          sse_algorithm = "aws:kms"
          kms_master_key_id = "arn:aws:kms:us-east-1:123456789012:key/alias/aws/s3"
        }
      }
    ]
  } 
}