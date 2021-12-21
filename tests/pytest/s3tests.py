import os
import json
import boto3
import pytest

##################################################################

# Read json file from terraform output
@pytest.fixture
def testdata():
    dir_path = os.path.dirname(os.path.realpath(__file__))
    path = dir_path + '/terraform_output.json'
    data = {
        'region': 'eu-central-1', # Adding custom region to json parameters
        'path': (path)
    }
    return data

@pytest.fixture
def readterraout(testdata):
    data = {}
    with open(testdata['path'], 'r') as f:
        output_json = json.load(f)
    for output_key, output_value in output_json.items():
        data[output_key] = output_value['value']
    data = data['s3_all'][0] # Filter values from output key
    return data # Return a list of values

##################################################################

# AWS-S3-001
# Test if the AWS S3 bucket was created
def test_s3_bucket_created(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS S3 Bucket Test")
    record_xml_attribute("name", "aws-s3-001 - AWS S3 bucket"
                         + " has been successfully created.")
    # Define the new S3 bucket
    bucketName = readterraout['bucket_name'][0]
    # Select all S3 buckets in account
    s3 = boto3.client('s3', region_name="{}".format(testdata['region']))
    response = s3.list_buckets()
    # Get all buckets names
    buckets = [bucket['Name'] for bucket in response['Buckets']]
    # Assert if bucketName exist in buckets
    assert bucketName in buckets

# AWS-S3-002
# Test if the AWS S3 bucket was created in the right region
def test_s3_bucket_region(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS S3 Bucket Test")
    record_xml_attribute("name", "aws-s3-002 - AWS S3 bucket"
                         + " is created in the right region.")
    # Define the new S3 bucket vars
    bucketName = readterraout['bucket_name'][0]
    bucketRegion = readterraout['bucket_region'][0]
    # Select the S3 created
    s3 = boto3.client('s3', region_name="{}".format(testdata['region']))
    bucket_region = s3.get_bucket_location(Bucket=bucketName)
    # Assert if bucket exist in the right region
    assert bucketRegion == bucket_region['LocationConstraint'] #print(bucket_region)

# AWS-S3-003
# Test if the AWS S3 bucket implements security controls
def test_s3_bucket_security(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS S3 Bucket Test")
    record_xml_attribute("name", "aws-s3-003 - AWS S3 bucket"
                         + " implements the mandatory security controls.")
    # Define the new S3 bucket vars
    bucketName = readterraout['bucket_name'][0]
    # Select the S3 created
    s3 = boto3.client('s3', region_name="{}".format(testdata['region']))
    # Assert if ACL public is blocked
    bucket_policy = s3.get_public_access_block(Bucket=bucketName)
    assert bucket_policy['PublicAccessBlockConfiguration']['BlockPublicAcls'] == True #print(bucket_policy)
    assert bucket_policy['PublicAccessBlockConfiguration']['IgnorePublicAcls'] == True #print(bucket_policy)
    assert bucket_policy['PublicAccessBlockConfiguration']['BlockPublicPolicy'] == True #print(bucket_policy)
    assert bucket_policy['PublicAccessBlockConfiguration']['RestrictPublicBuckets'] == True #print(bucket_policy)
    # Assert if bucket is encrypted
    bucket_encrypted = s3.get_bucket_encryption(Bucket=bucketName)
    assert bucket_encrypted['ServerSideEncryptionConfiguration']['Rules'][0]['ApplyServerSideEncryptionByDefault']['SSEAlgorithm'] == 'aws:kms' #print(bucket_encrypted)
    # Assert if versiones is enabled
    bucket_versioning = s3.get_bucket_versioning(Bucket=bucketName)
    assert bucket_versioning['Status'] == 'Enabled' #print(bucket_versioning)  

# AWS-S3-004
# Test list objects in an AWS S3 bucket
def test_s3_bucket_objects_list(record_xml_attribute, testdata, readterraout):
    record_xml_attribute("classname", "AWS S3 Bucket Test")
    record_xml_attribute("name", "aws-s3-004 - AWS S3 bucket"
                         + " list objects.")
    # Select the S3 created
    s3 = boto3.resource('s3', region_name="{}".format(testdata['region']))
    bucket = s3.Bucket(readterraout['bucket_name'][0])
    # List objects from the bucket
    for obj in bucket.objects.all():
        print(obj.key)
    # Assert the name of the bucket
    assert bucket

