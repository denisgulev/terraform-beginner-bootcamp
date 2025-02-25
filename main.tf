terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {}
provider "random" {}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}

resource "random_string" "bucket_name" {
  lower   = true
  upper   = false
  length  = 32
  special = false
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}
