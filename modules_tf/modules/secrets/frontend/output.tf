output "secrets_frontend_arn" {
  value       = aws_secretsmanager_secret.frontend_vars.arn
}

output "secrets_frontend_name" {
  value       = aws_secretsmanager_secret.frontend_vars.name
}