variable "name" {}
variable "trusted_aws_services" {
  type    = list(any)
  default = []
}
variable "create_instance_profile" {
  default = false
}
variable "attach_policies" {
  type    = list(any)
  default = []
}
variable "policy" {}
variable "permissions_boundary" { default = "" }