
terraform {

    backend "s3" {
       bucket         = "airbnb-project46qwo9klci"
       key            = "terraform/state"
       use_lockfile = true
       encrypt = true
       
    }

    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~>5.0"
        }
    }
    
    required_version = ">= 1.0.0"
}