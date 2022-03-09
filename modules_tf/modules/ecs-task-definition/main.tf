###########################################
# ECS Task Definition
###########################################
resource "aws_ecs_task_definition" "backend" {
  family                = "${var.name}-backend"
  container_definitions = file("${path.module}/task-definition/backend.json")
}

resource "aws_ecs_task_definition" "odoo" {
  family                = "${var.name}-odoo"
  container_definitions = file("${path.module}/task-definition/odoo.json")
}

resource "aws_ecs_task_definition" "matching" {
  family                = "${var.name}-matching"
  container_definitions = file("${path.module}/task-definition/matching.json")
}

resource "aws_ecs_task_definition" "celery" {
  family                = "${var.name}-celery"
  container_definitions = file("${path.module}/task-definition/celery.json")
}