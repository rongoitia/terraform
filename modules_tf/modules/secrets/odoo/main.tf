resource "aws_secretsmanager_secret" "odoo_vars" {
  name = "${var.name}-odoo"
  recovery_window_in_days = 0
}




