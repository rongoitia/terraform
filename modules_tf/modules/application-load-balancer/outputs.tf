output "alb_backend_name" {
 value       = aws_alb.backend.name
}
output "alb_backend_arn_suffix" {
 value       = aws_alb.backend.arn_suffix
}
output "alb_backend_domain" {
  value      = aws_alb.backend.dns_name
}

#BACKEND
output "tg_backend_1_arn" {
 value       = aws_lb_target_group.tg_backend_1.arn
}
output "tg_backend_1_name" {
 value       = aws_lb_target_group.tg_backend_1.name
}
output "tg_backend_2_arn" {
 value       = aws_lb_target_group.tg_backend_2.arn
}
output "tg_backend_2_name" {
 value       = aws_lb_target_group.tg_backend_2.name
}
output "listener_backend_https_arn" {
 value       = aws_alb_listener.alb_backend_listener_https.arn
}


#ODOO
output "alb_odoo_name" {
 value       = aws_alb.odoo.name
}
output "alb_odoo_domain" {
  value      = aws_alb.odoo.dns_name
}
output "alb_odoo_arn_suffix" {
 value       = aws_alb.odoo.arn_suffix
}
output "tg_odoo_1_arn" {
 value       = aws_lb_target_group.tg_odoo_1.arn
}
output "tg_odoo_1_name" {
 value       = aws_lb_target_group.tg_odoo_1.name
}
output "tg_odoo_2_arn" {
 value       = aws_lb_target_group.tg_odoo_2.arn
}
output "tg_odoo_2_name" {
 value       = aws_lb_target_group.tg_odoo_2.name
}
output "listener_odoo_https_arn" {
 value       = aws_alb_listener.alb_odoo_listener_https.arn
}

# #MATCHING
# output "alb_matching_name" {
#  value       = aws_alb.matching.name
# }
# output "alb_matching_domain" {
#   value      = aws_alb.matching.dns_name
# }
# output "alb_matching_arn_suffix" {
#  value       = aws_alb.matching.arn_suffix
# }
# output "tg_matching_1_arn" {
#  value       = aws_lb_target_group.tg_matching_1.arn
# }
# output "tg_matching_1_name" {
#  value       = aws_lb_target_group.tg_matching_1.name
# }
# output "tg_matching_2_arn" {
#  value       = aws_lb_target_group.tg_matching_2.arn
# }
# output "tg_matching_2_name" {
#  value       = aws_lb_target_group.tg_matching_2.name
# }
# output "listener_matching_https_arn" {
#  value       = aws_alb_listener.alb_matching_listener_https.arn
# }

#CELERY
output "alb_celery_name" {
 value       = aws_alb.celery.name
}
output "alb_celery_domain" {
  value      = aws_alb.celery.dns_name
}
output "alb_celery_arn_suffix" {
 value       = aws_alb.celery.arn_suffix
}
output "tg_celery_1_arn" {
 value       = aws_lb_target_group.tg_celery_1.arn
}
output "tg_celery_1_name" {
 value       = aws_lb_target_group.tg_celery_1.name
}
output "tg_celery_2_arn" {
 value       = aws_lb_target_group.tg_celery_2.arn
}
output "tg_celery_2_name" {
 value       = aws_lb_target_group.tg_celery_2.name
}
output "listener_celery_https_arn" {
 value       = aws_alb_listener.alb_celery_listener_https.arn
}
