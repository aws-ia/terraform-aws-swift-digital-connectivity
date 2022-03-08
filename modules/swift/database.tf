module "database" {
  source = "../database"

  subnet_ids = var.database_subnet_ids
  kms_key    = var.database_kms_key
  security_group_ids = [
    module.sg_rds.id,
  ]
}
