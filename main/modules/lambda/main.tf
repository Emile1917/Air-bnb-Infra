

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./utilities/lambda_function.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "csv_formatter" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.lambda.output_path
  function_name = var.lambda_function_name
  role          = var.lambda_role_name
  #handler       = "index.test"
  
  source_code_hash = data.archive_file.lambda.output_base64sha256
  architectures = [ "x86_64" ]
  runtime = var.lambda_runtime
  memory_size = var.lambda_memory_size
  timeout = var.lambda_timeout
  ephemeral_storage {
    size = var.ephemeral_storage_size
  }
  layers = [var.lambda_layer_pandas_arn]

  reserved_concurrent_executions = -1
  environment {
    variables = {
      foo = "air-bnb"
    }
  }
  depends_on = [ aws_lambda_permission.s3_invocation ,aws_cloudwatch_log_group.aws_lambda_log ]
}


resource "aws_cloudwatch_log_group" "aws_lambda_log" {
  name              = "/aws/lambda/${aws.lambda_function.csv_formatter.function_name}"
  retention_in_days = 14
}
/*
resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = var.lambda_layer_filename
  layer_name = var.lambda_layer_name
  
  compatible_runtimes = [var.lambda_runtime]

  dpu to memory size ratio in aws
}
*/
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = var.trigger_bucket_name
  lambda_function {
    lambda_function_arn = aws_lambda_function.csv_formatter.arn
    events              = ["s3:ObjectCreated:*"]

  }

  depends_on = [ aws_lambda_permission.s3_invocation]
}
resource "aws_lambda_permission" "s3_invocation" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.csv_formatter.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.trigger_bucket_arn
}


resource "aws_lambda_function_event_invoke_config" "example" {
  function_name = aws_lambda_function.csv_formatter.function_name

  destination_config {
    on_failure {
      destination = var.failure_topic_arn
    }


    on_success {
      destination = var.success_queue_arn
    }
  }
}