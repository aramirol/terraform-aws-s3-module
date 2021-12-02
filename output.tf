# S3 outputs

output "bucket_name" {
  description = "Bucket name"
  value       = "${aws_s3_bucket.s3.*.bucket}"
}

output "bucket_acl" {
  description = "Bucket ACL"
  value       = "${aws_s3_bucket.s3.*.acl}"
}