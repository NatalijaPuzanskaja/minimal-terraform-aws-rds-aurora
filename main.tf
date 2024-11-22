provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "account-name": var.aws_account_name
    }
  }
}

module "postgre-aurora" {
  source                        = "./modules/postgre-aurora"
  aws_region                    = var.aws_region

  identifier                    = var.identifier
  engine_version                = var.engine_version

  deletion_protection           = var.deletion_protection

  backup_retention_period       = var.backup_retention_period
  preferred_backup_window       = var.preferred_backup_window

  preferred_maintenance_window  = var.preferred_maintenance_window

  pass_rotate_after_days        = var.pass_rotate_after_days

  tags = {
    role      = "aurora"
    scheduled = true
  }
}
