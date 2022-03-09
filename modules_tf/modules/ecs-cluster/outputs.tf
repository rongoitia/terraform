output "ecs_cluster_arn_backend" {
  value       = aws_ecs_cluster.backend.arn
}
output "ecs_cluster_arn_odoo" {
  value       = aws_ecs_cluster.odoo.arn
}
# output "ecs_cluster_arn_matching" {
#   value       = aws_ecs_cluster.matching.arn
# }
output "ecs_cluster_arn_celery" {
  value       = aws_ecs_cluster.celery.arn
}



output "ecs_cluster_name_backend" {
  value       = aws_ecs_cluster.backend.name
}
output "ecs_cluster_name_odoo" {
  value       = aws_ecs_cluster.odoo.name
}
# output "ecs_cluster_name_matching" {
#   value       = aws_ecs_cluster.matching.name
# }
output "ecs_cluster_name_celery" {
  value       = aws_ecs_cluster.celery.name
}



