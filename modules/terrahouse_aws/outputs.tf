output "bucket_name" {
  value = aws_s3_bucket.web-hosting.bucket
}

output "s3_website_endpoint" {
  description = "The endpoint URL for the website hosted on S3"
  value       = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

output "s3_distribution_endpoint" {
  description = "The endpoint URL for the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}
