variable "region" {
  type        = string
  default     = "us-east-1"
  description = "What AWS region to deploy resources in."
}

variable "az_count" {
  type        = number
  default     = 2
  description = "The number of az's to deploy in"
}

variable "vpc_id" {
  type        = string
  description = "ID of target VPC"
  default     = null
}