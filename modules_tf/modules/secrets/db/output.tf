output "secrets_db_arn" {
  value       = aws_secretsmanager_secret.db_vars.arn
}
output "secrets_db_name" {
  value       = aws_secretsmanager_secret.db_vars.name
}