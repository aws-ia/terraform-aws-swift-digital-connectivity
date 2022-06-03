variable "subnet_ids" {
  type        = list(any)
  description = "IDs of subnets to deploy the database"
}

variable "instance_class" {
  type        = string
  default     = "db.m5.large"
  description = "Instance class of the db"
}

variable "allocated_storage" {
  type        = number
  default     = 100
  description = "Allocated storage for db"
}

variable "kms_key" {
  type        = string
  description = "KMS key for db"
}

variable "security_group_ids" {
  type        = list(any)
  description = "IDs of security groups"
}

variable "username" {
  type        = string
  default     = "admin"
  description = "The username for db"
}