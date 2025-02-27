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

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.web-hosting.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.web-hosting.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  etag = filemd5("${path.root}/public/index.html")
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  count        = fileexists("${path.root}/public/index.html") ? 1 : 0
  bucket       = aws_s3_bucket.web-hosting.bucket
  key          = "index.html"
  source       = "${path.root}/public/index.html"
  content_type = "text/html"

  etag = filemd5("${path.root}/public/index.html")
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "error_html" {
  count        = fileexists("${path.root}/public/error.html") ? 1 : 0
  bucket       = aws_s3_bucket.web-hosting.bucket
  key          = "error.html"
  source       = "${path.root}/public/error.html"
  content_type = "text/html"

  etag = filemd5("${path.root}/public/error.html")
}
