output "secrets_backend_arn" {
  value       = aws_secretsmanager_secret.backend_vars.arn
}

output "secrets_backend_name" {
  value       = aws_secretsmanager_secret.backend_vars.name
}