provider "awscc" {
  region = var.region
}

# Declare the data source
data "aws_availability_zones" "available" {}

module "workload_vpc" {
  source     = "aws-ia/vpc/aws"
  version    = ">= 1.0.0"
  name       = "workload-vpc"
  cidr_block = "10.0.0.0/16"
  az_count   = 3

  subnets = {
    public = {
      cidrs = ["10.0.0.0/20"]
    }

    private = {
      cidrs = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
    }
  }

  vpc_flow_logs = {
    log_destination_type = "cloud-watch-logs"
    retention_in_days    = 7
  }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_kms_key" "database" {
  description             = "KMS key for database"
  deletion_window_in_days = 10
}

resource "aws_kms_key" "amh" {
  description             = "KMS key for AMH"
  deletion_window_in_days = 10
}

module "basic_swift_connectivity" {
  source = "../../"

  vpc_id              = module.workload_vpc.vpc_attributes.id
  ssh_key_name        = aws_key_pair.generated_key.key_name
  amh_kms_key         = aws_kms_key.amh.arn
  database_kms_key    = aws_kms_key.database.arn
  amh_subnet_ids      = [for az, subnet in module.workload_vpc.vpc_attributes.public_subnet_attributes_by_az : subnet.id]
  database_subnet_ids = [for az, subnet in module.workload_vpc.vpc_attributes.private_subnet_attributes_by_az : subnet.id]
}
