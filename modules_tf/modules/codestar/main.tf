resource "aws_codestarconnections_connection" "codestar_conn" {
  name                        = "${var.environment}-${var.app_name}-connection"
  provider_type               = "GitHub"
}
