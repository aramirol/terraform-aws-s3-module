# S3 outputs

output "backet_name" {
  description = "Bucket name"
  value       = "${aws_s3_bucket.s3.*.bucket}"
}

output "backet_acl" {
  description = "Bucket ACL"
  value       = "${aws_s3_bucket.s3.*.acl}"
}