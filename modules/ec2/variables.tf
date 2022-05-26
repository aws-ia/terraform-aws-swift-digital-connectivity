variable "subnets" {
  type = map(object({
    subnet_id = string
  }))
}

variable "security_group_ids" {
  type = list(any)
}

variable "ssh_key_name" {
  type = string
}
variable "instance_type" {
  type    = string
  default = "m5.xlarge"
}

variable "volume_size" {
  type    = number
  default = 100
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "kms_key" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "ami_id" {
  type = string
  description = "AMI id"
}

variable "instance_profile" {
  type    = string
  default = ""
  description = "Name of the IAM Instance Profile to launch the instance with"
}

variable "disable_api_termination" {
  type    = string
  default = false # for testing purposes only
  description = "True if disable api termination is enabled"
}

variable "user_data" {
  type = string
  default = ""
}