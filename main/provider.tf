provider "aws" {
  
}

data "aws_caller_identity" "current_user" {}

data "aws_region" "current_region" {}
output "account_id" {
  value = data.aws_caller_identity.current_user.account_id
}

output "region" {
  value = data.aws_region.current_region.name
}