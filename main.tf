# AMH - this main.tf file serves as an example or blueprint for a customer's AMH deployment
# all resources below are listed as examples and should be reviewed carefully for each customers' environment
locals {
  amh_user_data = <<EOF
#!/bin/sh
sleep 120
dnf config-manager --disable rhui-client-config-server-8
dnf config-manager --disable rhel-8-appstream-rhui-rpms
dnf config-manager --disable rhel-8-baseos-rhui-rpms
dnf install -y https://s3.${data.aws_region.current.name}.amazonaws.com/amazon-ssm-${data.aws_region.current.name}/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
curl https://s3.${data.aws_region.current.name}.amazonaws.com/amazoncloudwatch-agent-${data.aws_region.current.name}/redhat/amd64/latest/amazon-cloudwatch-agent.rpm -o /tmp/amazon-cloudwatch-agent.rpm rpm -U /tmp/amazon-cloudwatch-agent.rpm
curl https://aws-quickstart-${data.aws_region.current.name}.s3.${data.aws_region.current.name}.amazonaws.com/quickstart-swift-digital-connectivity/assets/cw_agent_config.json -o /tmp/cw_agent_config.json /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ct -a fetch-config -m ec2 -s -c file:/tmp/cw_agent_config.json
EOF
}

# This resource should be stored in the user's TFSTAT file and should be encrypted
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_kms_key" "amh" {
  count                   = var.amh_kms_key == null ? 1 : 0
  description             = "KMS key for AMH"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

module "amh" {
  source = "./modules/ec2"

  subnets = var.amh_subnet_ids
  security_group_ids = [
    module.sg_amh.id,
  ]
  ssh_key_name     = aws_key_pair.generated_key.key_name
  user_data        = local.amh_user_data
  ami_id           = data.aws_ami.rhel.id
  instance_profile = module.amh_functional_role.instance_profile_name
  kms_key          = var.amh_kms_key == null ? aws_kms_key.amh[0].arn : var.amh_kms_key
  tags = {
    Name = "AMH"
  }

}

data "aws_ami" "rhel" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-8.3.0_HVM-????????-x86_64-0-Hourly2-GP2"]
  }

  owners = ["309956199498"]
}

data "aws_region" "current" {}

resource "aws_kms_key" "database" {
  count                   = var.database_kms_key == null ? 1 : 0
  description             = "KMS key for database"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# Database
module "database" {
  source = "./modules/database"

  subnet_ids = var.database_subnet_ids
  secrets_key    = var.database_kms_key == null ? aws_kms_key.database[0].arn : var.secrets_key
  kms_key    = var.database_kms_key == null ? aws_kms_key.database[0].arn : var.database_kms_key
  security_group_ids = [
    module.sg_rds.id,
  ]
}

# IAM
module "amh_functional_role" {
  source = "./modules/iam/role"

  name = "amh-functional-role"
  trusted_aws_services = [
    "ec2.amazonaws.com"
  ]
  create_instance_profile = true
  attach_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
  policy = jsonencode(
    {
      "Version" : "2012-10-17"
      "Statement" : [
        {
          "Action" : "s3:GetObject",
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:s3:::aws-quickstart-eu-west-1/*",
            "arn:aws:s3:::amazoncloudwatch-agent-eu-west-1/*",
            "arn:aws:s3:::aws-ssm-eu-west-1/*",
            "arn:aws:s3:::aws-windows-downloads-eu-west-1/*",
            "arn:aws:s3:::amazon-ssm-eu-west-1/*",
            "arn:aws:s3:::amazon-ssm-packages-eu-west-1/*",
            "arn:aws:s3:::eu-west-1-birdwatcher-prod/*",
            "arn:aws:s3:::aws-ssm-distributor-file-eu-west-1/*",
            "arn:aws:s3:::patch-baseline-snapshot-eu-west-1/*"
          ],
          "Sid" : "SSMPermissionsPolicyForSSMandCWAgent"
        },
        {
          "Action" : [
            "cloudwatch:PutMetricData",
            "ec2:DescribeVolumes",
            "ec2:DescribeTags",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams",
            "logs:DescribeLogGroups",
            "logs:CreateLogStream",
            "logs:CreateLogGroup"
          ],
          "Effect" : "Allow",
          "Resource" : "*",
          "Sid" : "CWAgentPermissions"
        },
        {
          "Action" : "ssm:GetParameter",
          "Effect" : "Allow",
          "Resource" : "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*",
          "Sid" : "SSMParameterStorePermissions"
        }
      ],
    }
  )
}

# Security groups
# AMH
module "sg_amh" {
  source = "./modules/sg"

  name   = "amh"
  vpc_id = var.vpc_id
  ingress_rules = [
    {
      cidr_blocks = [var.workstation_ip_range]
      description = "workstation-connectivity"
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
    },
  ]
  egress_rules = [
    {
      description = "amh-to-rds-1521"
      from_port   = 1521
      to_port     = 1521
      protocol    = "tcp"
      security_groups = [
        module.sg_rds.id
      ]
    }
  ]
}

# RDS
module "sg_rds" {
  source = "./modules/sg"

  name   = "rds"
  vpc_id = var.vpc_id
  egress_rules = [
    {
      cidr_blocks = ["255.255.255.255/32"]
      description = "disallow-all-traffic" # ported from cdk
      from_port   = 252
      protocol    = "icmp"
      to_port     = 86
    },
  ]
}
