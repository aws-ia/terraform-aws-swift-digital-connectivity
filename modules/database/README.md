<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 0.21.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.73.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_secretsmanager_secret.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.master](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Allocated storage for db | `number` | `100` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance class of the db | `string` | `"db.m5.large"` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | KMS key for db | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | IDs of security groups | `list(any)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | IDs of subnets to deploy the database | `list(any)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The username for db | `string` | `"admin"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->