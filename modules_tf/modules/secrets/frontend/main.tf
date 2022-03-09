resource "aws_secretsmanager_secret" "frontend_vars" {
  name = "${var.name}-frontend"
  recovery_window_in_days = 0
}




