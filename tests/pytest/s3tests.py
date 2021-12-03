import os
import json
import boto3
import pytest


# Test if there are more than 0 buckets
def test_s3_bucket_created():
    # Call S3 to list current buckets
	s3 = boto3.client('s3', region_name='eu-central-1')
	response = s3.list_buckets()

	# Get a list of all bucket names from the response
	buckets = [bucket['Name'] for bucket in response['Buckets']]

	assert len(buckets) >= 1


# Print number of buckets
client = boto3.client('s3')
response = client.list_buckets()
print(len(response['Buckets']))


# Print the name of the bucket
s3 = boto3.client('s3', region_name='eu-central-1')
response = s3.list_buckets()
print('Existing buckets:')
for bucket in response['Buckets']:
    if bucket["Name"] == "aramirol-tf-iac-test":
        print(f'  {bucket["Name"]}')


# Test if I can list all buckets
def test_s3_bucket_list():
    # Call S3 to list current buckets
	s3 = boto3.client('s3', region_name='eu-central-1')
	response = s3.list_buckets()

	# Get a list of all bucket names from the response
	assert [bucket['Name'] for bucket in response['Buckets']]
