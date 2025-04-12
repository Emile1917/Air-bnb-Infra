
resource "aws_kms_key" "athena_key" {
  deletion_window_in_days = 7
  description             = "Athena KMS Key"

}


resource "aws_athena_data_catalog" "example" {
  name        = var.aws_athena_data_catalog_name
  description = "Glue based Data Catalog"
  type        = "GLUE"


  parameters = {

    "catalog-id" = "123456789012"
  }
}



resource "aws_athena_database" "example" {
  name   = var.athena_database_name
  bucket = var.s3_output_bucket_name

}

resource "aws_athena_workgroup" "wg_athena" {
  name = var.wg_name

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${var.s3_output_bucket_name}/athena-results/"

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = aws_kms_key.athena_key.arn
      }
    }
  }
}