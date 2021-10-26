# Terraform AWS S3 Module

![](https://img.shields.io/badge/terraform-v1.0.9-blueviolet?logo=terraform)
![](https://img.shields.io/badge/aws-3.63.0-yellow?logo=amazonaws)
![](https://img.shields.io/badge/localstack-latest-white?logo=github)

Simple terraform module testing with `localstack`.

![](images/module-pipeline.png)

## Example

```sh
provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "eu-central-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"

  endpoints {
    s3            = "http://127.0.0.1:4566"
  }
}
```
