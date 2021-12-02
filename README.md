# Terraform S3 Module example

![](https://img.shields.io/badge/terraform-v1.0.9-blueviolet?logo=terraform)
![](https://img.shields.io/badge/aws-3.63.0-yellow?logo=amazonaws)

[![Build Status (Master)](https://rbalvjenkinm.bas.roche.com/job/IAC_ENG/job/IAC_ENG/job/terraform-module-aws-vpc-example/job/master/badge/icon)](https://rbalvjenkinm.bas.roche.com/job/IAC_ENG/job/IAC_ENG/job/terraform-module-aws-vpc-example/job/master/)

## Introduction

This code is an example of a terraform module. Create an S3 cube with some additional settings like lifecycle, versioning, or encryption.

This code is for a:\
[X] COMPONENT [ ] ENABLER

## Framework or Coding Technology

-----BEGIN TECH-----\
TECH-Main: terraform\
TECH-Testing: python-unittest, python-unittest-xml-reporting\
TECH-Auxiliary: N/A\
TECH-CICD: Jenkinsfile\
-----END TECH-----

# Execution methods

## From command line

```bash
$ git clone -b 1.0.0 –-depth 1 https://bitbk.roche.com/scm/iac_eng/terraform-module-aws-s3-example.git
$ cd terraform-module-aws-s3-example
$ terraform init
$ terraform validate
$ terraform plan
$ terraform apply -auto-approve -parallelism=2
```

## From a terraform implementation file

```hcl
# Testing S3 Terraform Module

# Apply region configuration
provider "aws" {
  region  = "eu-central-1"
}

# Calling S3 module
module "s3" {
  source  = "git::https://bitbk.roche.com/scm/iac_eng/terraform-module-aws-s3-example.git?ref=1.0.0"
}

output "s3_all" {
  description = "Show all"
  value       = module.s3.*
}
```
## Inputs

| Name | Type | Required | Description |
| ---- | ---- | -------- | ----------- |
| **bucket_name** | `string` | yes | Name of the S3 bucket |
| **bucket_acl** | `string` | yes | ACL policy of the S3 bucket. Private by default |
| **bucket_region** | `string` | yes | Region where S3 bucket will located. "eu-central-1" by defaut |
| **bucket_tag_name** | `string` | yes | A tag with a name to the S3 bucket |
| **bucket_tag_env** | `string` | yes | A tag with the environment where S3 bucket will be located |
| **bucket_key_deletion_days** | `number` | yes | A number of days between 7 and 30 |

## Outputs

| Name | Type | Description |
| ---- | ---- | ----------- |
| **bucket_name** | `string` | Name of the S3 bucket created |
| **bucket_acl** | `string` | ACL policy of the S3 bucket created |

## Dependencies

| Software/Framework/Code repository                           | Version/Description                                          |
| :------------------ | :--------------------|
| terraform   | >= 0.12.31   |
| [terraform-provider-aws](https://github.com/hashicorp/terraform-provider-aws) | >= 3.60"  |
| [python-dependencies.txt](./tests/pytest/python-dependencies.txt) | See python dependencies file for software and version details |

## Tested Versions

|         **Version**         | **Release Date** | **Build number** |
| :-------------------------: | :--------------: | :--------------: |
|   terraform-provider-aws    |    03/12/2021    |     v3.60.0      |

## Supporting Documents, Handbooks, QPs and TOPs

| **Requirements** | **Link** |
| :--------------: | :------: |
|       N/A        |   N/A    |

| **Design Documents (HLD/LLD/etc.)** |                           **Link**                           |
| :---------------------------------: | :----------------------------------------------------------: |
|        Solution Architecture        |                             N/A                              |

| **TOPs/QPs/WIs** | **Link** |
| :--------------: | :------: |
|       N/A        |   N/A    |

## Manual Tests

N/A

## Deviations and open defects

N/A

## Author Information

IaC Engineering Team (https://iac-portal.roche.com)

## License

Copyright (c) 2021 F. Hoffmann-La Roche Ltd. All rights reserved.\
Roche Global Infrastructure & Solutions.

