# terraform-aws-s3-module Unit Tests
---

These test are an example of a terraform module.
Tests check that S3 bucket exists with some security controls.

## Changelog
[View Changelog](CHANGELOG.md)

## Test Script

- `s3tests.rb` : Check the information of S3.

## Corresponding Requirements

- [aws-s3-001.setup-a-s3-bucket.md](../../requirements/aws-s3-001.setup-a-s3-bucket.md)
- [aws-s3-002.setup-bucket-in-the-specific-region.md](../../requirements/aws-s3-002.setup-bucket-in-the-specific-region.md)
- [aws-s3-003.setup-security-compliance.md](../../requirements/aws-s3-003.setup-security-compliance.md)

## Inputs

A script is running in jenkins pipeline to auto convert the terraform output json to the unittest input file format, taking the output name and value as the key: value pair. Therefore the inputs here are all the defined outputs from output.tf. Some additional variables like `TERRA_EXAMPLE_AK` and `TERRA_EXAMPLE_SK` are from ROCHE Conjur.

The script is as followings:

```
terraform output --json > ./inspec/files/terraform_output.json
```

## Run the Test Cases

Run test cases through scripts in the Jenkins pipeline.

The script is as followings:

```sh
inspec exec inspec -t aws:// --chef-license accept-silent --reporter cli junit:./inspec/reports/junits_out.xml
```
