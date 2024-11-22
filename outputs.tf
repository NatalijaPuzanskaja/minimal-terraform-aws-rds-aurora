output "arn" {
  value       = module.postgre-aurora.aurora_cluster_arn
  description = "Aurora cluster ARN"
}

output "endpoint" {
  value       = module.postgre-aurora.aurora_cluster_endpoint
  description = "Aurora cluster endpoint"
}

output "vpc_id" {
  value       = module.postgre-aurora.vpc_id
  description = "AWS account internal VPC ID"
}

output "subnet_ids" {
  value       = module.postgre-aurora.subnet_ids
  description = "AWS account internal subnet IDs in internal VPC"
}

output "pass_rotate_after_days" {
  value       = module.postgre-aurora.master_user_password_rotation_automatically_after_days
  description = "Debug: ensure module gets the pass_rotate_after_days variable"
}
