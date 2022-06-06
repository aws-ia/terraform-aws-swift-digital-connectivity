variable "name" {
  type = string
  description = "Name of IAM role"
}

variable "trusted_aws_services" {
  type    = list(any)
  default = []
  description = "AWS services to be trusted"
}

variable "create_instance_profile" {
  default = false
  description = "Flag to use for creating a profile"
}

variable "attach_policies" {
  type    = list(any)
  default = []
  description = "Policies to include"
}

variable "policy" {
  type = string
  description = "Name of policy"
}

variable "permissions_boundary" {
  type    = string
  default = ""
  description = "Name of permissions boundary to use"
}