output "db_subnet_group_id" {
 value       = aws_db_subnet_group.db_subnet_group.id
}

output "rds_id" {
 value       = aws_db_instance.postgres.id
}

