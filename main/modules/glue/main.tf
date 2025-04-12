

resource "aws_glue_catalog_database" "airbnb_database" {
  name = var.catalog_database_name

}

resource "aws_glue_classifier" "custom_json_classifier_name" {
  name = var.custom_csv_classifier_name

  json_classifier {
    json_path = "$[*]"
  }
}

resource "aws_glue_classifier" "custom_csv_classifier_name" {
  name = var.custom_json_classifier_name

  csv_classifier {
    quote_symbol = "\""
    contains_header = "PRESENT"
    delimiter = ","
    serde = "OpenCSVSerDe"
  }
}


resource "aws_glue_crawler" "airbnb_crawler" {
  database_name = aws_glue_catalog_database.airbnb_database.name
  name          = var.crawler_name
  role          = var.crawler_role_arn
  classifiers = [aws_glue_classifier.example.name]
  s3_target {
    path = "s3://${var.bucket_name}/"

  }
}