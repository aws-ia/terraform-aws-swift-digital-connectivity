provider "awscc" {
  region = var.region
}

module "workload_vpc" {
  source     = "aws-ia/vpc/aws"
  version    = "1.1.4"
  name       = "workload-vpc"
  cidr_block = "10.0.0.0/16"
  az_count   = var.az_count
  vpc_id     = var.vpc_id

  subnets = {
    public = {
      cidrs = ["10.0.0.0/20", "10.0.16.0/20"]
    }

    private = {
      cidrs = ["10.0.48.0/20", "10.0.64.0/20"]
    }
  }

  vpc_flow_logs = {
    log_destination_type = "cloud-watch-logs"
    retention_in_days    = 7
  }
}

locals {
  public_subnets  = [for az, subnet in module.workload_vpc.public_subnet_attributes_by_az : subnet.id]
  private_subnets = [for az, subnet in module.workload_vpc.private_subnet_attributes_by_az : subnet.id]
  vpc_id          = module.workload_vpc.vpc_attributes.id
}

module "basic_swift_connectivity" {
  source = "../../"

  vpc_id = local.vpc_id
  amh_subnet_ids = {
    subnet1 = {
      subnet_id = local.public_subnets[0]
    },
    subnet2 = {
      subnet_id = local.public_subnets[1]
    }
  }
  database_subnet_ids = local.private_subnets
}
