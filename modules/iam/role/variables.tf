variable "name" {
  type = string
}

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

variable "policy" {
  type = string
}

variable "permissions_boundary" {
  type    = string
  default = ""
}