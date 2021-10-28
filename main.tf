# S3 resource

resource "aws_s3_bucket" "bucket_test" {
  bucket = var.bucket_name
  acl    = var.bucket_acl
  region = var.bucket_region

  tags = {
    Name        = "My bucket"
    Environment = "Bucket test"
  }
}