output "secret_key_name" {
  value       = aws_ssm_parameter.private_key_secret.name
}
