output "arn" {
  description = "Aurora cluster ARN"
  value       = module.postgre-aurora.aurora_cluster_arn
}

output "endpoint" {
  description = "Aurora cluster endpoint"
  value       = module.postgre-aurora.aurora_cluster_endpoint
}

output "vpc_id_filtered" {
  description = "AWS account internal VPC ID"
  value       = data.aws_vpc.internal.id
}

output "subnet_ids_filtered" {
  description = "AWS account internal subnet IDs in internal VPC"
  value       = data.aws_subnets.internal.ids
}

output "subnet_ids_applied" {
  description = "AWS account internal subnet IDs in internal VPC"
  value       = module.postgre-aurora.aurora_cluster_subnet_ids
}
