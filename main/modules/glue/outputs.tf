output "glue_catalog_name" {
  value = aws_glue_catalog_database.airbnb_database.name 
}

output "glue_crawler_role_arn" {
    value = aws_glue_crawler.airbnb_crawler.role
}