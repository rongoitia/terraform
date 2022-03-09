resource "aws_ssm_parameter" "private_key_secret" {
  name        = "${var.environment}-private-key"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.private_key

  tags = {
    environment = "${var.environment}"
  }
}