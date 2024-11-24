# AWS parameters
aws_region                    = "eu-west-1"
aws_account_name              = "personal-natalija"
# Aurora PostgreSQL parameters
engine_version                = 16.4
name                          = "risk-app"
identifier                    = "playground-test"
cluster_members               = ["one"]
deletion_protection           = false
backup_retention_period       = 3
preferred_backup_window       = "02:00-03:00"
preferred_maintenance_window  = "sun:05:00-sun:06:00"
pass_rotate_after_days        = 90
