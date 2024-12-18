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
  aws_account_name              = var.aws_account_name

  name                          = var.name
  identifier                    = var.identifier
  engine_version                = var.engine_version
  cluster_members               = var.cluster_members

  vpc_id                        = data.aws_vpc.internal.id
  vpc_cidr_blocks               = data.aws_vpc.internal.cidr_block
  subnet_ids                    = data.aws_subnets.internal.ids
  db_subnet_group_name          = "${var.identifier}-subnet-group"
  availability_zones            = data.aws_availability_zones.region.names

  deletion_protection           = var.deletion_protection

  backup_retention_period       = var.backup_retention_period
  preferred_backup_window       = var.preferred_backup_window

  preferred_maintenance_window  = var.preferred_maintenance_window

  pass_rotate_after_days        = var.pass_rotate_after_days

  ec2_ami                       = data.aws_ami.amazon_linux_2_ssm.id

  tags = {
    role      = "aurora"
    scheduled = true
  }
}
