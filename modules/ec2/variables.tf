variable "subnets" {
  type = map(object({
    subnet_id = string
  }))
  description = "The subnet to be used"
}

variable "security_group_ids" {
  type = list(any)
  description = "List of security group IDs"
}

variable "ssh_key_name" {
  type = string
  description = "Name of the ssh key"
}
variable "instance_type" {
  type    = string
  default = "m5.xlarge"
  description = "The type of EC2 instance"
}

variable "volume_size" {
  type    = number
  default = 100
  description = "Volume size to be used"
}

variable "volume_type" {
  type    = string
  default = "gp3"
  description = "Type of EBS volume"
}

variable "kms_key" {
  type = string
  description = "KMS key to be used for encryption"
}

variable "tags" {
  type    = map(any)
  default = {}
  description = "Resource tags for the instance"
}

variable "ami_id" {
  type        = string
  description = "AMI id"
}

variable "instance_profile" {
  type        = string
  default     = ""
  description = "Name of the IAM Instance Profile to launch the instance with"
}

variable "disable_api_termination" {
  type        = string
  default     = false # for testing purposes only
  description = "True if disable api termination is enabled"
}

variable "user_data" {
  type    = string
  default = ""
  description = "Any other user data to be used for the instance"
}