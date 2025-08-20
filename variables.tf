variable "amh_subnet_ids" {
  type = map(object({
    subnet_id = string
  }))
  description = "List of subnet IDs for the AMH EC2 instances."
}

variable "database_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS database."
}

# variable "quickstart_s3_bucket" {
#  type = string
#  default     = "aws-quickstart"
#  description = "Name of the S3 bucket with scripts for this solution."
# }

# variable "iam_role_permissions_boundary" {
#  type = string
#  default     = ""
#  description = "Optional Amazon Resource Name (ARN) to a permissions boundary policy for the role."
# }

variable "vpc_id" {
  type        = string
  description = "ID of the target VPC."
  default     = ""
}

# variable "swift_ip_range" {
#  type = string
#  default     = "149.134.0.0/16"
#  description = "Range of IP addresses for SWIFT connectivity."
# }

# variable "hsm_ip" {
#  type = string
#  default     = "10.20.1.10/32"
#  description = "Range of IP addresses for hardware security module (HSM) connectivity."
# }

variable "workstation_ip_range" {
  type        = string
  default     = "10.1.0.0/16"
  description = "Range of IP addresses for administrator workstations."
}

# variable "sagsnl1_ip" {
#  type = string
#  default     = "10.10.0.10"
#  description = "IP address of the first SAG/SNL server."
# }

# variable "sagsnl2_ip" {
#  type = string
#  default     = "10.10.1.10"
#  description = "IP address of the second SAG/SNL server."
# }

variable "amh_kms_key" {
  type        = string
  description = "Amazon Resource Name (ARN) to the key that's used for encrypting AMH instance volumes."
  default     = null
}

variable "secrets_key" {
  type        = string
  description = "ARN to the key that's used for Secrets Manager."
  default     = null
}

variable "database_kms_key" {
  type        = string
  description = "ARN to the key that's used for encrypting the RDS database."
  default     = null
}

variable "key_name" {
  type        = string
  default     = "swift"
  description = "Name of the SSH (Secure Shell) key."
}
