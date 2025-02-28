terraform {
  cloud {
    organization = "Terraform-bootcamp-aws"
    workspaces {
      name = "Terraform-1"
    }
  }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"

  user_uuid       = var.user_uuid
  bucket_name     = var.bucket_name
  content_version = var.content_version
}
