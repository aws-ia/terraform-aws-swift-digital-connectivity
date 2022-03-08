variable "amh_subnet_ids" {
  type        = list(any)
  description = "List of subnet IDs for AMH EC2 instances"
}

variable "database_subnet_ids" {
  type        = list(any)
  description = "List of subnet IDs for RDS database"
}

variable "quickstart_s3_bucket" {
  default     = "aws-quickstart"
  description = "A name of the bucket with quickstart scripts"
}
variable "iam_role_permissions_boundary" {
  default     = ""
  description = "Optional ARN to a permissions boundary policy for the role."
}
variable "vpc_id" {
  description = "ID of target VPC"
}
variable "ssh_key_name" {
  description = "Name of the key to use as a default SSH key for AMH instance"
}
variable "swift_ip_range" {
  default     = "149.134.0.0/16"
  description = "Range of IPs for SWIFT connectivity"
}
variable "hsm_ip" {
  default     = "10.20.1.10/32"
  description = "Range of IPs for HSM connectivity"
}
variable "workstation_ip_range" {
  default     = "10.1.0.0/16"
  description = "Range of IPS for administrator workstations"
}
variable "sagsnl1_ip" {
  default     = "10.10.0.10"
  description = "IP of the first SAG/SNL server"
}
variable "sagsnl2_ip" {
  default     = "10.10.1.10"
  description = "IP of the second SAG/SNL server"
}
variable "amh_kms_key" {
  description = "ARN to the key used for encrypting AMH instance volumes"
}
variable "database_kms_key" {
  description = "ARN to the key used for encrypting RDS database"
}
variable "iam_role_name_prefix" {
  default     = ""
  description = "Optional prefix for role names"
}