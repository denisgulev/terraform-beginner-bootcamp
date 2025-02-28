
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

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.web-hosting.bucket
  # policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.web-hosting.bucket}/*",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
          }
        }
      }
    ]
  })
}
