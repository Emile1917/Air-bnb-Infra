locals {
  # The bucket name is passed as a variable to the module
  bucket_arn = var.bucket_arn

}



resource "aws_iam_role_policy" "lambda_policy" {
  name = var.lambda_policy_name
  role = aws_iam_role.lambda_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Sid = "statement1",
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
        ]
        Effect = "Allow"
        Resource = [
          "${local.bucket_arn}",
          "${local.bucket_arn}/*",
        ]
      },
      { Sid ="statement2"
        Effect = "Allow",
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream"
        ],
        Resource = "${var.cloudwatch_arn}"
      },
      { Sid ="statement3"
        Effect = "Allow",
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
        ],
        Resource = "${var.sqs_arn}"
      },
      { Sid ="statement4"
        Effect = "Allow",
        Action = [
          "sns:Publish",
          "sns:Subscribe",
          "sns:Receive",
        ],
        Resource = "${var.sns_arn}"
      }
    ]
  })
}

resource "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}




data "aws_iam_policy_document" "assume_role_glue_crawler" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "glue_crawler_role" {
  name               = var.aws_glue_crawler_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_glue_crawler.json
}

/*
data "aws_iam_policy_document" "glue_crawler_policy" {
  version = var.role_version
 dynamic statement {
    for_each = var.statements

    content {
  
    sid       = statement.value.sid
    effect    = statement.value.effect
    actions   = statement.value.actions
    resources = statement.value.resources

    }
    
  }
}
*/

resource "aws_iam_policy" "glue_crawl_policy" {
  name        = var.aws_glue_crawler_policy_name
  description = "A policy for the glue crawler"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Sid = "statement10",
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
        ]
        Effect = "Allow"
        Resource = [
          "${local.bucket_arn}",
          "${local.bucket_arn}/*",
        ]
      },
    ]})




}

resource "aws_iam_role_policy_attachment" "test-attach" {
  for_each = to_set([ aws_iam_policy.glue_crawl_policy.arn , var.aws_glue_managed_policy_arn ])
  role       = aws_iam_role.glue_crawler_role.name
  policy_arn = each.key
}

/*
- write the policy and the role for the glue crawler
- find the name of the lamda function file and zip it in the current working directory
- find the arn of the pandas lambda layer for python 3.11
*/

