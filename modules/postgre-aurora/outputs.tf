output "aurora_cluster_arn" {
  description = "Aurora cluster ARN"
  value       = aws_rds_cluster.this[0].arn
}

output "aurora_cluster_endpoint" {
  description = "Aurora cluster endpoint"
  value       = aws_rds_cluster.this[0].endpoint
}

output "aurora_cluster_subnet_ids" {
  description = "Aurora cluster subnet ids"
  value       = aws_db_subnet_group.this.subnet_ids
}
