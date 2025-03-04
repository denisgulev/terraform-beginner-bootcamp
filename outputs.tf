output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value       = module.terrahouse_aws.bucket_name
  sensitive   = true
}

output "s3_website_endpoint" {
  description = "The endpoint URL for the website hosted on S3"
  value       = module.terrahouse_aws.s3_website_endpoint
}

output "s3_distribution_endpoint" {
  description = "The endpoint URL for the CloudFront distribution"
  value       = module.terrahouse_aws.s3_distribution_endpoint
}
