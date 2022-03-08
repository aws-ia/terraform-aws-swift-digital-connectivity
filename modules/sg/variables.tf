variable "name" {}
variable "ingress_rules" {
  type    = list(any)
  default = []
}
variable "egress_rules" {
  type    = list(any)
  default = []
}
variable "vpc_id" {}