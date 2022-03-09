resource "aws_cloudwatch_log_group" "ecs_backend" {
  name                  = "/ecs/workera-${var.environment}-backend"
  retention_in_days     = 400

  tags = {
    environment         = var.environment
  }
}

resource "aws_cloudwatch_log_group" "ecs_celery_backend" {
  name                  = "/ecs/workera-${var.environment}-celery-backend"
  retention_in_days     = 400

  tags = {
    environment         = var.environment
  }
}

resource "aws_cloudwatch_log_group" "ecs_matching" {
  name                  = "/ecs/workera-${var.environment}-matching"
  retention_in_days     = 400

  tags = {
    environment         = var.environment
  }
}

resource "aws_cloudwatch_log_group" "ecs_odoo" {
  name                  = "/ecs/workera-${var.environment}-odoo"
  retention_in_days     = 400

  tags = {
    environment         = var.environment
  }
}