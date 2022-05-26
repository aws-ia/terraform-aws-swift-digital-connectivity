<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_basic_swift_connectivity"></a> [basic\_swift\_connectivity](#module\_basic\_swift\_connectivity) | ../../ | n/a |
| <a name="module_workload_vpc"></a> [workload\_vpc](#module\_workload\_vpc) | aws-ia/vpc/aws | 1.1.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_count"></a> [az\_count](#input\_az\_count) | The number of az's to deploy in | `number` | `2` | no |
| <a name="input_region"></a> [region](#input\_region) | What AWS region to deploy resources in. | `string` | `"us-east-1"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of target VPC | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->