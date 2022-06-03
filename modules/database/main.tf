resource "aws_db_subnet_group" "group" {
  description = "subnet group for AMH RDS Oracle instance"
  subnet_ids  = var.subnet_ids
}

resource "random_password" "master" {
  length           = 30
  special          = false
  override_special = " %+~`#$&*()|[]{}:;<>?!'/@\"\\"
}

resource "aws_secretsmanager_secret_version" "master" {
  secret_id     = aws_secretsmanager_secret.master.id
  secret_string = <<EOF
{
  "username": "${var.username}",
  "password": "${random_password.master.result}"
}
EOF
}

resource "aws_secretsmanager_secret" "master" {
  name_prefix = "amh-rds-database-master"
}

resource "aws_db_instance" "name" {
  copy_tags_to_snapshot  = true
  allocated_storage      = var.allocated_storage
  instance_class         = var.instance_class
  db_subnet_group_name   = aws_db_subnet_group.group.name
  engine                 = "oracle-ee"
  engine_version         = "19.0.0.0.ru-2021-10.rur-2021-10.r1"
  kms_key_id             = var.kms_key
  username               = var.username
  password               = random_password.master.result
  publicly_accessible    = false
  multi_az               = true
  storage_encrypted      = true
  storage_type           = "gp2"
  vpc_security_group_ids = var.security_group_ids
  skip_final_snapshot    = true # for testing only - https://github.com/hashicorp/terraform-provider-aws/issues/92#issuecomment-626289241
  enabled_cloudwatch_logs_exports = [
    "trace",
    "audit",
    "alert",
    "listener"
  ]

  lifecycle {
    ignore_changes = [
      engine_version,
    ]
  }
}
