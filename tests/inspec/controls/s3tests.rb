# Input variables
content = inspec.profile.file("terraform_output.json")
params  = JSON.parse(content)

# Get json values
#bucketName = params['bucket_name']['value']
bucketName = 'aramirol-tf-iac-test'

# Local variables
allowedRegions = [ "eu-central-1", "eu-west-1", "us-west-2" ]

# Controls

control "S3BucketExists" do
  impact 1.0
  title "S3 Bucket Exists Test"
  desc "Checking if the AWS S3 bucket has been successfully created"
  
  describe aws_s3_bucket(bucketName) do
    it { should exist }
  end
end

control "S3Region" do
  impact 1.0
  title "S3 Region Test"
  desc "Checking if the AWS S3 bucket is created in the right region"
  
  describe aws_s3_bucket(bucketName) do
    its('region') { should be_in allowedRegions }
  end
end

control "S3Security" do
  impact 1.0
  title "S3 Security Tests"
  desc "Checking if the AWS S3 bucket implements the mandatory security controls"
  
  #describe aws_s3_bucket(bucketName) do
  #  its('bucket_policy') { should_not be_empty }
  #end
  describe aws_s3_bucket(bucketName) do
    it { should_not be_public }
  end
#  describe aws_s3_bucket(bucketName) do
#    it { should have_default_encryption_enabled }
#  end
  describe aws_s3_bucket(bucketName) do
    it { should have_versioning_enabled }
  end
#  describe aws_s3_buckets(bucket_names: bucketName) do
#    its('tags') { should include(key: 'Name', value: 'Roche-test') }
#    its('tags') { should include(:Environment => 'Dev-test',:Name => 'Roche-test')}
#  end
end