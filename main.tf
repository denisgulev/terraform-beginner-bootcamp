resource "aws_s3_bucket" "web-hosting" {
  bucket = var.bucket_name

  tags = {
    UserUuid = var.user_uuid
  }
}
