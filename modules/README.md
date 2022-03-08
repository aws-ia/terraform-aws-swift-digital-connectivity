# Introduction

The repository provides an example for running SWIFT CSP compliant environment using Terraform to provision all resources.

The Terraform code is based on SWIFT Quickstart template (https://aws.amazon.com/quickstart/architecture/swift-client-connectivity/) with the following changes and assumptions:

* The code uses existing VPC - high security environments usually have VPC already provisioned, the template reuses it.
* The code doesn't manage NACL rules - customers have dedicated teams that manage both VPC as well as routing and firewall settings.
* The template supports deployment of AMH component and it's database, all other components (like MQ) should be provisioned separately
* The template adds support for IAM permissions boundary as well as name prefixing for the IAM roles
* The SSH key should be provisioned separately and it's name should be provided to the module variables

# Sample usage

Below you'll find minimal Terraform environment that provisions the resources:

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.49.0"
    }
  }
}

provider "aws" {
  region = "af-south-1"
}

module "swift" {
  source = "./modules/swift"

  vpc_id                        = "TODO"
  ssh_key_name                  = "TODO"
  amh_kms_key                   = "arn:aws:kms:eu-west-1:123456789012:key/todo"
  database_kms_key              = "arn:aws:kms:eu-west-1:123456789012:key/todo"
  iam_role_permissions_boundary = ""
  iam_role_name_prefix          = "Bounded"
  amh_subnet_ids = [
    "subnet-1",
    "subnet-2",
  ]
  database_subnet_ids = [
    "subnet-1",
    "subnet-2",
  ]
}
```

## Module inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amh_kms_key"></a> [amh\_kms\_key](#input\_amh\_kms\_key) | ARN to the key used for encrypting AMH instance volumes | `any` | n/a | yes |
| <a name="input_amh_subnet_ids"></a> [amh\_subnet\_ids](#input\_amh\_subnet\_ids) | List of subnet IDs for AMH EC2 instances | `list(any)` | n/a | yes |
| <a name="input_database_kms_key"></a> [database\_kms\_key](#input\_database\_kms\_key) | ARN to the key used for encrypting RDS database | `any` | n/a | yes |
| <a name="input_database_subnet_ids"></a> [database\_subnet\_ids](#input\_database\_subnet\_ids) | List of subnet IDs for RDS database | `list(any)` | n/a | yes |
| <a name="input_hsm_ip"></a> [hsm\_ip](#input\_hsm\_ip) | Range of IPs for HSM connectivity | `string` | `"10.20.1.10/32"` | no |
| <a name="input_iam_role_name_prefix"></a> [iam\_role\_name\_prefix](#input\_iam\_role\_name\_prefix) | Optional prefix for role names | `string` | `""` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | Optional ARN to a permissions boundary policy for the role. | `string` | `""` | no |
| <a name="input_quickstart_s3_bucket"></a> [quickstart\_s3\_bucket](#input\_quickstart\_s3\_bucket) | A name of the bucket with quickstart scripts | `string` | `"aws-quickstart"` | no |
| <a name="input_sagsnl1_ip"></a> [sagsnl1\_ip](#input\_sagsnl1\_ip) | IP of the first SAG/SNL server | `string` | `"10.10.0.10"` | no |
| <a name="input_sagsnl2_ip"></a> [sagsnl2\_ip](#input\_sagsnl2\_ip) | IP of the second SAG/SNL server | `string` | `"10.10.1.10"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | Name of the key to use as a default SSH key for AMH instance | `any` | n/a | yes |
| <a name="input_swift_ip_range"></a> [swift\_ip\_range](#input\_swift\_ip\_range) | Range of IPs for SWIFT connectivity | `string` | `"149.134.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of target VPC | `any` | n/a | yes |
| <a name="input_workstation_ip_range"></a> [workstation\_ip\_range](#input\_workstation\_ip\_range) | Range of IPS for administrator workstations | `string` | `"10.1.0.0/16"` | no |

## Outputs

No outputs.
