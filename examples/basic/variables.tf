variable "region" {
  type        = string
  default     = "us-east-1"
  description = "What AWS region to deploy resources in."
}

variable "key_name" {
  type        = string
  default     = "swift"
  description = "The name of the SSH key"
}