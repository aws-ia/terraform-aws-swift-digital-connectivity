terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.49.0"
    }
  }
}

provider "aws" {
  region = "af-south-1"
}

module "swift" {
  source = "./modules/swift"

  vpc_id                        = "TODO"
  ssh_key_name                  = "TODO"
  amh_kms_key                   = "arn:aws:kms:eu-west-1:123456789012:key/todo"
  database_kms_key              = "arn:aws:kms:eu-west-1:123456789012:key/todo"
  iam_role_permissions_boundary = ""
  iam_role_name_prefix          = "Bounded"
  amh_subnet_ids = [
    "subnet-1",
    "subnet-2",
  ]
  database_subnet_ids = [
    "subnet-1",
    "subnet-2",
  ]
}
