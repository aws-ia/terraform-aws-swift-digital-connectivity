variable "subnet" {}
variable "security_group_ids" {
  type = list(any)
}
variable "ssh_key_name" {}
variable "instance_type" { default = "m5.xlarge" }
variable "volume_size" { default = 100 }
variable "volume_type" { default = "gp3"}
variable "kms_key" {}
variable "tags" {
  type    = map(any)
  default = {}
}
variable "user_data" { default = "" }
variable "ami_id" {}
variable "instance_profile" { default = "" }
variable "disable_api_termination" { default = true }
