import os
import json
import boto3
import pytest

# Retrieve the list of existing buckets
s3 = boto3.client('s3')
response = s3.list_buckets()

# Output the bucket names
print('Existing buckets:')
for bucket in response['Buckets']:
    if bucket["Name"] == "aramirol-tf-iac-test":
        print(f'  {bucket["Name"]}')

@pytest.fixture
def s3storagebucket():
    s3 = boto3.client('s3')
    response = s3.list_buckets()
    print('Existing buckets:')
    for bucket in response['Buckets']:
        if bucket["Name"] == "aramirol-tf-iac-test":
            print(f'  {bucket["Name"]}')
            
    assert len(buckets) == 1
# Set variables.

@pytest.fixture
def testdata():
    dir_path = os.path.dirname(os.path.realpath(__file__))
    path = dir_path + '/terraform_output.json'
    data = {
        'region': 'eu-central-1',
        'path': (path)
    }
    return data

# Read json output from terraform.

@pytest.fixture
def readterraout(testdata):
    data = {}
    with open(testdata['path'], 'r') as f:
        output_json = json.load(f)
    for output_key, output_value in output_json.items():
        data[output_key] = output_value['value']
    data = data['bucket_name'][0]
    return data

# ======= Tests definitions =========
