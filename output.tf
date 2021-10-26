output "backet_name" {
  description = "Bucket name"
  value       = "${aws_s3_bucket.bucket_test.*.bucket}"
}

output "backet_acl" {
  description = "Bucket ACL"
  value       = "${aws_s3_bucket.bucket_test.*.acl}"
}