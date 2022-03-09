output "task_definition_arn_backend" {
  value       = aws_ecs_task_definition.backend.arn
}

output "task_definition_arn_odoo" {
  value       = aws_ecs_task_definition.odoo.arn
}

output "task_definition_arn_matching" {
  value       = aws_ecs_task_definition.matching.arn
}

output "task_definition_arn_celery" {
  value       = aws_ecs_task_definition.celery.arn
}