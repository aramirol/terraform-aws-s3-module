# S3 vars

variable "bucket_name" {
  description = "Name of the bucket"
  default = "aramirol-tf-iac-test"
}

variable "bucket_acl" {
  description = "ACL mode private or public"
  default = "private"
}

variable "bucket_tag_name" {
  description = "Tag Name"
  default = "Roche-test"
}

variable "bucket_tag_env" {
  description = "Tag Environment"
  default = "Dev-test"
}
