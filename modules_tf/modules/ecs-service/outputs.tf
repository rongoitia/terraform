output "ecs_service_backend" {
  value       = aws_ecs_service.backend.name
}

output "ecs_service_odoo" {
  value       = aws_ecs_service.odoo.name
}

# output "ecs_service_matching" {
#   value       = aws_ecs_service.matching.name
# }

output "ecs_service_celery" {
  value       = aws_ecs_service.celery.name
}