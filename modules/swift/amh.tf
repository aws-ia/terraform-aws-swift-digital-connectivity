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

module "amh" {
  source = "../ec2"

  for_each = toset(var.amh_subnet_ids)

  subnet = each.key
  security_group_ids = [
    module.sg_amh.id,
  ]
  ssh_key_name     = var.ssh_key_name
  user_data        = local.amh_user_data
  ami_id           = data.aws_ami.rhel.id
  instance_profile = module.amh_functional_role.instance_profile_name
  kms_key          = var.amh_kms_key
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
