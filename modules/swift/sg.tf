// AMH
module "sg_amh" {
  source = "../sg"

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

// RDS
module "sg_rds" {
  source = "../sg"

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
