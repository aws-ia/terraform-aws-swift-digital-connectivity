resource "aws_instance" "main" {
  for_each = var.subnets

  ami                         = var.ami_id
  associate_public_ip_address = false
  disable_api_termination     = var.disable_api_termination
  http_tokens                 = required
  iam_instance_profile        = var.instance_profile
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  subnet_id                   = each.value["subnet_id"]
  tags                        = var.tags
  volume_tags                 = var.tags
  vpc_security_group_ids      = var.security_group_ids


  root_block_device {
    volume_size = var.volume_size
    encrypted   = true
    kms_key_id  = var.kms_key
    volume_type = var.volume_type
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data,
    ]
  }
}
