resource "aws_secretsmanager_secret" "backend_vars" {
  name = "${var.name}-backend"
  recovery_window_in_days = 0
    #   lifecycle {
    #         prevent_destroy = true
    # }
}