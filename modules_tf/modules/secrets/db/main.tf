resource "aws_secretsmanager_secret" "db_vars" {
  name = "${var.name}-db"
  recovery_window_in_days = 0
}


resource "aws_secretsmanager_secret_version" "db_vars_version" {
  secret_id     = aws_secretsmanager_secret.db_vars.id
  secret_string = <<EOF
  {
    "HOST_PROD" :   "",
    "DB_PROD"   :   ""
  }
  EOF

  lifecycle {
    ignore_changes = all
  }
}

