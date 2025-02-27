terraform {
  cloud {
    organization = "Terraform-bootcamp-aws"
    workspaces {
      name = "Terraform-1"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_s3_bucket" "web-hosting" {
  bucket = var.bucket_name

  tags = {
    UserUuid = var.user_uuid
  }
}
