variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "aws_account_name" {
  description = "AWS account name"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of VPC"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs used by database subnet group created"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "The name of the subnet group name (existing or created)"
  type        = string
  default     = ""
}

variable "engine_version" {
  description = "The database engine version. Updating this argument results in an outage"
  type        = string
  default     = null
}

variable "name" {
  description = "Name used across resources created"
  type        = string
  default     = ""
}

variable "identifier" {
  description = "A name for Aurora cluster"
  type        = string
  default     = null
}

variable "cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  type        = list(string)
  default     = null
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`. The default is `false`"
  type        = bool
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = null
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled using the `backup_retention_period` parameter. Time in UTC"
  type        = string
  default     = "02:00-03:00"
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur, in (UTC)"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "pass_rotate_after_days" {
  description = "Specifies the number of days between automatic scheduled rotations of the secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified"
  type        = number
  default     = null
}
