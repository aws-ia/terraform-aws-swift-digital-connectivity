variable "region" {
  type        = string
  default     = "af-south-1"
  description = "What AWS region to deploy resources in."
}

variable "key_name" {
  type        = string
  default     = "swift"
  description = "The name of the SSH key"
}