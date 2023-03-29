<!-- BEGIN_TF_DOCS -->
# SWIFT Client Connectivity—Terraform module

This solution uses a [Terraform module](https://registry.terraform.io/modules/aws-ia/swift-digital-connectivity/aws/latest) to deploy [SWIFT](https://www.swift.com/) Client Connectivity in the Amazon Web Services (AWS) Cloud. It creates a standardized environment for organizations with backend payment applications that need to interface with the SWIFT financial-messaging network.

This module's default configuration follows the SWIFT Customer Security Programme (CSP) controls and the SWIFT Customer Security Controls Framework (CSCF), which comprises mandatory and advisory security controls for all SWIFT users. These templates do not replace the need for customer guidance when implementing SWIFT security controls in the cloud.

AWS is responsible for complying with certain SWIFT CSP requirements. A certificate of AWS compliance with SWIFT CSP controls is available through AWS Artifact. Certification is provided by Dixio.

AWS has also published a solution for deploying SWIFT Client Connectivity using AWS Cloud Development Kit (AWS CDK).

Deploying this solution does not guarantee an organization’s compliance with any laws, certifications, policies, or other regulations.

This Partner Solution was developed by AWS.

## Costs and licenses

This deployment requires a SWIFT account and software license. To register for a SWIFT account, refer to [How to become a swift.com user?](https://www.swift.com/myswift/how-to-become-a-swift_com-user_)

There is no cost to use this solution, but you'll be billed for any AWS services or resources that this solution deploys. For more information, refer to the [AWS Partner Solution General Information Guide](https://fwd.aws/rA69w?).

## Architecture

This solution deploys into an existing virtual private cloud (VPC).

![Architecture for SWIFT Client Connectivity on AWS, Terraform module](https://raw.githubusercontent.com/aws-ia/terraform-aws-swift-digital-connectivity/main/images/swift-connectivity-terraform-architecture-diagram.png)

As shown in the diagram, this solution sets up the following:

* An architecture that spans two Availability Zones.
* A VPC configured with private subnets according to AWS best practices and following SWIFT CSP guidance.
* In the private subnets:
    * An Amazon Elastic Compute Cloud (Amazon EC2) instance that runs Alliance Messaging Hub (AMH) and SWIFT Alliance Access (SAA) or Lite2.
    * An EC2 instance that runs SWIFT Alliance Gateway (SAG) and SWIFTNet Link (SNL).
    * An Amazon Relational Database Service (Amazon RDS) Oracle instance running in active or standby mode to store configuration and message data for AMH.
    * (Optional) An Amazon MQ instance to handle communication for AMH.
* AWS Systems Manager, which removes the need for a jump server.
* Amazon CloudWatch, which provides the mechanism to store, access, and monitor SWIFT activities.
* AWS Secrets Manager, which encrypts, stores, and retrieves passwords.
* A virtual private network (VPN) gateway with load balancing, which connects the VPC to AWS Direct Connect.*
* AWS Direct Connect, which establishes private connectivity between AWS and data centers or colocation environments.*

*The Terraform module that deploys this solution does not include the components marked by asterisks because they require design decisions on how to connect to the SWIFT network.

## Deployment steps

1.	Install the latest version of Terraform. For instructions, refer to [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).
1.	Install the latest version of AWS Command Line Interface (AWS CLI). For instructions, refer to [Installing or updating the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
1.	Run `aws configure` to configure AWS CLI with the `ACCESS_KEY_ID`, `SECRET_ACCESS_KEY`, and `REGION` corresponding to your AWS Identity and Access Management (IAM) user.
1.	Configure Terraform, and edit `variables.tf` to fill in your information.
1.	Review the resources in `main.tf`, and edit as necessary with your details.
1.	Provision the environment by running the following:
    `terraform init`
    `terraform apply`

## More information

For more information, refer to the [deployment guide for SWIFT Client Connectivity Using AWS CDK](https://fwd.aws/agK6R?). That guide includes sections that pertain to both the AWS CDK version and the Terraform version of this solution, such as sections on connection options, specialized knowledge, security, troubleshooting, FAQ, customer responsibility, feedback, and notices.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 0.21.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.73.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 3.3.0 |

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
| [aws_key_pair.generated_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_kms_key.amh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [tls_private_key.example](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.rhel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amh_subnet_ids"></a> [amh\_subnet\_ids](#input\_amh\_subnet\_ids) | List of subnet IDs for the AMH EC2 instances. | <pre>map(object({<br>    subnet_id = string<br>  }))</pre> | n/a | yes |
| <a name="input_database_subnet_ids"></a> [database\_subnet\_ids](#input\_database\_subnet\_ids) | List of subnet IDs for the RDS database. | `list(string)` | n/a | yes |
| <a name="input_amh_kms_key"></a> [amh\_kms\_key](#input\_amh\_kms\_key) | Amazon Resource Name (ARN) to the key that's used for encrypting AMH instance volumes. | `string` | `null` | no |
| <a name="input_database_kms_key"></a> [database\_kms\_key](#input\_database\_kms\_key) | ARN to the key that's used for encrypting the RDS database. | `string` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the SSH (Secure Shell) key. | `string` | `"swift"` | no |
| <a name="input_secrets_key"></a> [secrets\_key](#input\_secrets\_key) | ARN to the key that's used for Secrets Manager. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the target VPC. | `string` | `""` | no |
| <a name="input_workstation_ip_range"></a> [workstation\_ip\_range](#input\_workstation\_ip\_range) | Range of IP addresses for administrator workstations. | `string` | `"10.1.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->