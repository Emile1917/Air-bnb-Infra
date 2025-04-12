

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

  acceleration_status = "Enabled"
  versioning = {
    enabled = true
  }
}


