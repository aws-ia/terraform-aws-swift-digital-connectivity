variable "subnet_ids" {
  type = list(any)
}
variable "instance_class" { default = "db.m5.large" }
variable "allocated_storage" { default = 100 }
variable "kms_key" {}
variable "security_group_ids" {
  type = list(any)
}
variable "username" { default = "admin" }

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
  name = "amh-rds-database-master"
}

resource "aws_db_instance" "name" {
  copy_tags_to_snapshot  = true
  allocated_storage      = var.allocated_storage
  instance_class         = var.instance_class
  db_subnet_group_name   = aws_db_subnet_group.group.name
  engine                 = "oracle-ee"
  engine_version         = "12.2.0.1.ru-2020-07.rur-2020-07.r1"
  kms_key_id             = var.kms_key
  username               = var.username
  password               = random_password.master.result
  publicly_accessible    = false
  multi_az               = true
  storage_encrypted      = true
  storage_type           = "gp2"
  vpc_security_group_ids = var.security_group_ids
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
