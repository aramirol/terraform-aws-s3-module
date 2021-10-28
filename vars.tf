# S3 vars

variable "bucket_name" {
  description = "Name of the bucket"
  default = "bucket-test"
}

variable "bucket_acl" {
  description = "ACL mode private or public"
  default = "private"
}

variable "bucket_region" {
  description = "Region of the bucket"
  default = "eu-central-1"
}