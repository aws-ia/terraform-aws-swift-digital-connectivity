variable "AWS_ACCESS_KEY_ID" {
  type = string
  description = "The ID of the access key for AWS"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  description = "The access key to be used for AWS"
}

variable "AWS_SESSION_TOKEN" {
  type = string
  description = "The session token for AWS"
}

variable "tfe_organization" {
  type    = string
  default = ""
  description = "The terraform organization to use"
}

variable "tfe_workspace" {
  type    = string
  default = ""
  description = "The terraform workspace name"
}

variable "tfe_email" {
  type    = string
  default = "someone@somewhere.someresource"
  description = "The email address to use"
}

variable "working_directory" {
  type    = string
  default = "/deploy"
  description = "The directory path to look in"
}

variable "region" {
  type        = string
  default     = "af-south-1"
  description = "What AWS region to deploy resources in."
}