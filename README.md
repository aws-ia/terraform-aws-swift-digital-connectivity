## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 0.9.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 0.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_amh"></a> [amh](#module\_amh) | ./modules/ec2 | n/a |
| <a name="module_amh_functional_role"></a> [amh\_functional\_role](#module\_amh\_functional\_role) | ./modules/iam/role | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./modules/database | n/a |
| <a name="module_sg_amh"></a> [sg\_amh](#module\_sg\_amh) | ./modules/sg | n/a |
| <a name="module_sg_rds"></a> [sg\_rds](#module\_sg\_rds) | ./modules/sg | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ami.rhel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amh_kms_key"></a> [amh\_kms\_key](#input\_amh\_kms\_key) | ARN to the key used for encrypting AMH instance volumes | `string` | n/a | yes |
| <a name="input_amh_subnet_ids"></a> [amh\_subnet\_ids](#input\_amh\_subnet\_ids) | List of subnet IDs for AMH EC2 instances | `list(any)` | n/a | yes |
| <a name="input_database_kms_key"></a> [database\_kms\_key](#input\_database\_kms\_key) | ARN to the key used for encrypting RDS database | `string` | n/a | yes |
| <a name="input_database_subnet_ids"></a> [database\_subnet\_ids](#input\_database\_subnet\_ids) | List of subnet IDs for RDS database | `list(any)` | n/a | yes |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | Name of the key to use as a default SSH key for AMH instance | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of target VPC | `string` | n/a | yes |
| <a name="input_workstation_ip_range"></a> [workstation\_ip\_range](#input\_workstation\_ip\_range) | Range of IPS for administrator workstations | `string` | `"10.1.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->