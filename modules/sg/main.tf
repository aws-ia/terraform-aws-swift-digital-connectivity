resource "aws_security_group" "sg" {
  name   = var.name
  vpc_id = var.vpc_id
  ingress = [
    for x in var.ingress_rules : {
      cidr_blocks      = lookup(x, "cidr_blocks", null)
      description      = lookup(x, "description", null)
      from_port        = lookup(x, "from_port", null)
      protocol         = lookup(x, "protocol", null)
      to_port          = lookup(x, "to_port", null)
      security_groups  = lookup(x, "security_groups", null)
      self             = lookup(x, "self", null)
      ipv6_cidr_blocks = lookup(x, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(x, "prefix_list_ids", null)
    }
  ]
  egress = [
    for x in var.egress_rules : {
      cidr_blocks      = lookup(x, "cidr_blocks", null)
      description      = lookup(x, "description", null)
      from_port        = lookup(x, "from_port", null)
      protocol         = lookup(x, "protocol", null)
      to_port          = lookup(x, "to_port", null)
      security_groups  = lookup(x, "security_groups", null)
      self             = lookup(x, "self", null)
      ipv6_cidr_blocks = lookup(x, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(x, "prefix_list_ids", null)
    }
  ]
}
