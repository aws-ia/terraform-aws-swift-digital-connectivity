variable "name" {
  type        = string
  description = "Name of security group"
}

variable "ingress_rules" {
  type        = list(any)
  default     = []
  description = "List of ingress rules"
}

variable "egress_rules" {
  type        = list(any)
  default     = []
  description = "List of egress rules"
}
variable "vpc_id" {
  type        = string
  description = "ID of VPC"
}