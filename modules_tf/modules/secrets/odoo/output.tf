output "secrets_odoo_arn" {
  value       = aws_secretsmanager_secret.odoo_vars.arn
}
output "secrets_odoo_name" {
  value       = aws_secretsmanager_secret.odoo_vars.name
}