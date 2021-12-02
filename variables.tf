#########################
# Variables

variable "bucket_name" {
  description = "Name of the bucket"
  type = string
  default = "aramirol-tf-iac-test"
}

variable "bucket_acl" {
  description = "ACL mode private or public"
  type = string
  default = "private"
}

variable "bucket_region" {
  description = "Region S3 located"
  type = string
  default = "eu-central-1"
}

variable "bucket_tag_name" {
  description = "Tag Name"
  type = string
  default = "Roche-test"
}

variable "bucket_tag_env" {
  description = "Tag Environment"
  type = string
  default = "Dev-test"
}

variable "bucket_key_deletion_days" {
  description = "After the waiting period ends, AWS KMS deletes the KMS key"
  type = number
  default = 10

  validation {
    condition = var.bucket_key_deletion_days >= 7 && var.bucket_key_deletion_days <= 30
    error_message = "It must be between 7 and 30, inclusive."
  }
}