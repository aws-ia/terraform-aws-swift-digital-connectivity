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