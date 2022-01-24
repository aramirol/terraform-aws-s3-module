#########################
# Variables

variable "bucket_name" {
  description = "Name of the bucket"
  type = string
  default = "roche-tf-module-test-iac"
}

variable "bucket_acl" {
  description = "ACL mode private or public"
  type = string
  default = "private"
}

variable "bucket_versioning" {
  type = bool
  default = true
}

variable "bucket_region" {
  description = "Region S3 located"
  type = string
  default = "eu-central-1"
}

variable "bucket_tag_name" {
  description = "Tag Name"
  type = string
  default = "roche-tf-module-test"
}

variable "bucket_tag_env" {
  description = "Tag Environment"
  type = string
  default = "roche-dev-test"
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

variable "block_public_acls" {
  description = "Block Public ACLs"
  type = bool
  default = true
}

variable "block_public_policy" {
  description = "Block Public Policy"
  type = bool
  default = true
}

variable "ignore_public_acls" {
  description = "Ignore Public ACLs"
  type = bool
  default = true
}

variable "restrict_public_buckets" {
  description = "Restrict Public Buckets"
  type = bool
  default = true
}
