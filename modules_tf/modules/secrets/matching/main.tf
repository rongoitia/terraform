resource "aws_secretsmanager_secret" "matching_vars" {
  name = "${var.name}-matching"
  recovery_window_in_days = 0
}





