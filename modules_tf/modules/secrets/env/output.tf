output "secrets_env_arn" {
  value       = aws_secretsmanager_secret.env_vars.arn
}

output "secrets_env_name" {
  value       = aws_secretsmanager_secret.env_vars.name
}