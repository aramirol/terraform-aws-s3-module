###########################################
# Testing S3 Terraform Module
###########################################

provider "aws" {
  region                      = "eu-central-1"
}

###########################################
# Calling S3 module
###########################################

module "s3" {
  source          = "../"
}

output "s3_all" {
  description = "Show all"
  value       = module.s3.*
}
