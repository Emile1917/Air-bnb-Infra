

locals {
  buckets = var.s3_bucket_names
}

resource "random_string" "rs" {
  count = length(local.buckets)
  length = 10
  min_lower = 7
  min_numeric = 3
}

module "s3_bucket" {
  count = length(local.buckets)
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "airbnb-project${random_string[count.index].rs.result}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
  acceleration_status = "Enabled"
  
}

module "sqs" {
  source = "./modules/sqs"
}

module "sns" {
  source = "./modules/sns"
}

module "iam" {
  source = "./modules/iam"
  bucket_arn = module.s3_bucket[count.index].arn
  sqs_arn = module.sqs.queue_arn
  sns_arn = module.sns.topic_arn
  }

module "lambda" {
  source = "./modules/lambda"
  lambda_role_name = module.iam.lambda_role_name
  failure_topic_arn = module.sns.topic_arn
  trigger_bucket_name = module.s3_bucket[0].bucket
  trigger_bucket_arn = module.s3_bucket[0].arn
  success_queue_arn = module.sqs.queue_arn
}

module "glue" {
  source = "./modules/glue"
  bucket_name = module.s3_bucket[0].bucket
  crawler_role_arn = module.iam.glue_crawler_role_arn
}

module "athena" {
  source = "./modules/athena"
  aws_athena_data_catalog_name = module.glue.catalog_database_name
  s3_output_bucket_name = module.s3_bucket[1].bucket
}