output "bucket_name" {
  value = aws_s3_bucket.web-hosting.bucket
}

output "s3_website_endpoint" {
  description = "The endpoint URL for the website hosted on S3"
  value       = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}
