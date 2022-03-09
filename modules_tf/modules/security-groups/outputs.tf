output "sg_db_name" {
  value       = aws_security_group.sg_db.name
}

output "sg_db_id" {
  value       = aws_security_group.sg_db.id
}

output "sg_ec2_name" {
  value       = aws_security_group.sg_ec2.name
}
output "sg_ec2_id" {
  value       = aws_security_group.sg_ec2.id
}



output "sg_ecs_name" {
  value       = aws_security_group.sg_ecs.name
}

output "sg_ecs_id" {
  value       = aws_security_group.sg_ecs.id
}

output "sg_ecs_id_backend" {
  value       = aws_security_group.sg_ecs_backend.id
}
output "sg_ecs_id_odoo" {
  value       = aws_security_group.sg_ecs_odoo.id
}

output "sg_ecs_id_matching" {
  value       = aws_security_group.sg_ecs_matching.id
}

output "sg_ecs_id_celery" {
  value       = aws_security_group.sg_ecs_celery.id
}

