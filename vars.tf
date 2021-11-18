# S3 vars

variable "bucket_name" {
  description = "Name of the bucket"
  default = "aramirol-terraform-bucket-test-1984"
}

variable "bucket_acl" {
  description = "ACL mode private or public"
  default = "private"
}
