
###########################################
###########################################
# Application Load Balancer BACKEND
###########################################
###########################################
resource "aws_alb" "backend" {
  name              = "${var.app_name}-${var.environment}-backend-lb"
  subnets           = var.subnets
  security_groups   = var.alb_security_group
  idle_timeout      = var.idle_timeout

  access_logs {
    bucket  = var.s3_access_log_name
    prefix  = "backend"
    enabled = true
  }
  tags ={
    Name            = "${var.app_name}-${var.environment}-backend-lb"

    VantaOwner  = "antonio@workera.ai"
    VantaNonProd  = false
    VantaDescription  = "${var.app_name}-${var.environment}-backend-lb"
    VantaContainsUserData  = false
  }
}
###########################################
# Target Group No1
###########################################
resource "aws_lb_target_group" "tg_backend_1" {
  name                          = "${var.app_name}-${var.environment}-tg-backend-1"
  tags= {
    Name                        = "${var.app_name}-${var.environment}-tg-backend-1"
  }
  port                          = var.alb_tg_port_backend
  protocol                      = var.alb_tg_protocol_backend
  vpc_id                        = var.vpc_id
  deregistration_delay          = var.deregistration_delay
  health_check {
    healthy_threshold           = 3
    unhealthy_threshold         = 10
    timeout                     = 5
    interval                    = 10
    path                        = var.alb_tg_path_backend
    #port                        = var.alb_tg_port_backend
    matcher                     = var.alb_tg_code_backend
  }
}
###########################################
# Target Group No2
###########################################
resource "aws_lb_target_group" "tg_backend_2" {
  name                          = "${var.app_name}-${var.environment}-tg-backend-2"
  tags= {
    Name                        = "${var.app_name}-${var.environment}-tg-backend-2"
  }
  port                          = var.alb_tg_port_backend
  protocol                      = var.alb_tg_protocol_backend
  vpc_id                        = var.vpc_id
  deregistration_delay          = var.deregistration_delay
  health_check {
    healthy_threshold           = 3
    unhealthy_threshold         = 10
    timeout                     = 5
    interval                    = 10
    path                        = var.alb_tg_path_backend
    #port                        = var.alb_tg_port_backend
    matcher                     = var.alb_tg_code_backend
  }

}
###########################################
# HTTP - Listener
###########################################
resource "aws_alb_listener" "alb_backend_listener_http" {
  load_balancer_arn  	        = aws_alb.backend.arn
  port               		      = "80"
  protocol           		      = "HTTP"

  default_action {
    type 			                = "redirect"

  redirect {
      port        		        = "443"
      protocol    		        = "HTTPS"
      status_code 		        = "HTTP_301"
  }
  }
  depends_on                  = [aws_alb.backend]

}
###########################################
# HTTPS - Listener
###########################################
resource "aws_alb_listener" "alb_backend_listener_https" {
  load_balancer_arn   = aws_alb.backend.arn
  port                = "443"
  protocol            = "HTTPS"
  ssl_policy          = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn     = var.certificate
  default_action {
    target_group_arn  = aws_lb_target_group.tg_backend_1.id
	  type              = "forward"
  }
  depends_on          = [aws_alb.backend]
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_lb_listener_rule" "backend_1" {
  listener_arn = aws_alb_listener.alb_backend_listener_https.arn
  priority     = 1
  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "We are in maintenance"
      status_code  = "200"
    }
  }
  condition {
    path_pattern {
      values = ["/maintenance/"]
    }
  }
}
resource "aws_lb_listener_rule" "backend_2" {
  listener_arn = aws_alb_listener.alb_backend_listener_https.arn
  priority     = 2
  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host        = "${var.frontend_subdomain}.${var.main_domain}"
      path        = "/candidates/"
    }
  }
  condition {
    path_pattern {
      values = ["/"]
    }
  }
}


###########################################
###########################################
# Application Load Balancer ODOO
###########################################
###########################################
resource "aws_alb" "odoo" {
  name              = "${var.app_name}-${var.environment}-odoo-lb"
  subnets           = var.subnets
  security_groups   = var.alb_security_group
  idle_timeout      = var.idle_timeout

  access_logs {
    bucket  = var.s3_access_log_name
    prefix  = "odoo"
    enabled = true
  }
  tags ={
    Name            = "${var.app_name}-${var.environment}-odoo-lb"

    VantaOwner  = "antonio@workera.ai"
    VantaNonProd  = false
    VantaDescription  = "${var.app_name}-${var.environment}-odoo-lb"
    VantaContainsUserData  = false
  }
}
###########################################
# Target Group No1
###########################################
resource "aws_lb_target_group" "tg_odoo_1" {
  name                          = "${var.app_name}-${var.environment}-tg-odoo-1"
  tags= {
    Name                        = "${var.app_name}-${var.environment}-tg-odoo-1"
  }
  port                          = var.alb_tg_port_odoo
  protocol                      = var.alb_tg_protocol_odoo
  vpc_id                        = var.vpc_id
  deregistration_delay          = var.deregistration_delay
  health_check {
    healthy_threshold           = 3
    unhealthy_threshold         = 10
    timeout                     = 5
    interval                    = 10

    path                        = var.alb_tg_path_odoo
    #port                        = var.alb_tg_port_odoo
    matcher                     = var.alb_tg_code_odoo
  }

}
###########################################
# Target Group No2
###########################################
resource "aws_lb_target_group" "tg_odoo_2" {
  name                          = "${var.app_name}-${var.environment}-tg-odoo-2"
  tags= {
    Name                        = "${var.app_name}-${var.environment}-tg-odoo-2"
  }
  port                          = var.alb_tg_port_odoo
  protocol                      = var.alb_tg_protocol_odoo
  vpc_id                        = var.vpc_id
  deregistration_delay          = var.deregistration_delay
  health_check {
    healthy_threshold           = 3
    unhealthy_threshold         = 10
    timeout                     = 5
    interval                    = 10
    path                        = var.alb_tg_path_odoo
    #port                        = var.alb_tg_port_odoo
    matcher                     = var.alb_tg_code_odoo
  }

}
###########################################
# HTTP - Listener
###########################################
resource "aws_alb_listener" "alb_odoo_listener_http" {
  load_balancer_arn  	        = aws_alb.odoo.arn
  port               		      = "80"
  protocol           		      = "HTTP"

  default_action {
    type 			                = "redirect"

  redirect {
      port        		        = "443"
      protocol    		        = "HTTPS"
      status_code 		        = "HTTP_301"
  }
  }
  depends_on                  = [aws_alb.odoo]

}
###########################################
# HTTPS - Listener
###########################################
resource "aws_alb_listener" "alb_odoo_listener_https" {
  load_balancer_arn   = aws_alb.odoo.arn
  port                = "443"
  protocol            = "HTTPS"
  ssl_policy          = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn     = var.certificate


  default_action {
    target_group_arn  = aws_lb_target_group.tg_odoo_1.id
	  type              = "forward"
  }
  depends_on          = [aws_alb.odoo]
  lifecycle {
    ignore_changes = all
  }
}




# ###########################################
# ###########################################
# # Application Load Balancer MATCHING
# ###########################################
# ###########################################
# resource "aws_alb" "matching" {
#   name              = "${var.app_name}-${var.environment}-matching-lb"
#   subnets           = var.subnets
#   security_groups   = var.alb_security_group
#   idle_timeout      = var.idle_timeout

#   access_logs {
#     bucket  = var.s3_access_log_name
#     prefix  = "matching"
#     enabled = true
#   }
#   tags ={
#     Name            = "${var.app_name}-${var.environment}-matching-lb"

#     VantaOwner  = "antonio@workera.ai"
#     VantaNonProd  = false
#     VantaDescription  = "${var.app_name}-${var.environment}-matching-lb"
#     VantaContainsUserData  = false
#   }
# }
# ###########################################
# # Target Group No1
# ###########################################
# resource "aws_lb_target_group" "tg_matching_1" {
#   name                          = "${var.app_name}-${var.environment}-tg-matching-1"
#   tags= {
#     Name                        = "${var.app_name}-${var.environment}-tg-matching-1"
#   }
#   port                          = var.alb_tg_port_matching
#   protocol                      = var.alb_tg_protocol_matching
#   vpc_id                        = var.vpc_id
#   deregistration_delay          = var.deregistration_delay
#   health_check {
#     healthy_threshold           = 3
#     unhealthy_threshold         = 10
#     timeout                     = 5
#     interval                    = 10

#     path                        = var.alb_tg_path_matching
#     #port                        = var.alb_tg_port_matching
#     matcher                     = var.alb_tg_code_matching
#   }

# }
# ###########################################
# # Target Group No2
# ###########################################
# resource "aws_lb_target_group" "tg_matching_2" {
#   name                          = "${var.app_name}-${var.environment}-tg-matching-2"
#   tags= {
#     Name                        = "${var.app_name}-${var.environment}-tg-matching-2"
#   }
#   port                          = var.alb_tg_port_matching
#   protocol                      = var.alb_tg_protocol_matching
#   vpc_id                        = var.vpc_id
#   deregistration_delay          = var.deregistration_delay
#   health_check {
#     healthy_threshold           = 3
#     unhealthy_threshold         = 10
#     timeout                     = 5
#     interval                    = 10
#     path                        = var.alb_tg_path_matching
#     #port                        = var.alb_tg_port_matching
#     matcher                     = var.alb_tg_code_matching
#   }

# }
# ###########################################
# # HTTP - Listener
# ###########################################
# resource "aws_alb_listener" "alb_matching_listener_http" {
#   load_balancer_arn  	        = aws_alb.matching.arn
#   port               		      = "80"
#   protocol           		      = "HTTP"

#   default_action {
#     type 			                = "redirect"

#   redirect {
#       port        		        = "443"
#       protocol    		        = "HTTPS"
#       status_code 		        = "HTTP_301"
#   }
#   }
#   depends_on                  = [aws_alb.matching]

# }
# ###########################################
# # HTTPS - Listener
# ###########################################
# resource "aws_alb_listener" "alb_matching_listener_https" {
#   load_balancer_arn   = aws_alb.matching.arn
#   port                = "443"
#   protocol            = "HTTPS"
#   ssl_policy          = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#   certificate_arn     = var.certificate


#   default_action {
#     target_group_arn  = aws_lb_target_group.tg_matching_1.id
# 	  type              = "forward"
#   }
#   depends_on          = [aws_alb.matching]
#   lifecycle {
#     ignore_changes = all
#   }
# }

###########################################
###########################################
# Application Load Balancer CELERY
###########################################
###########################################
resource "aws_alb" "celery" {
  name              = "${var.app_name}-${var.environment}-celery-lb"
  subnets           = var.subnets
  security_groups   = var.alb_security_group
  idle_timeout      = var.idle_timeout

  access_logs {
    bucket  = var.s3_access_log_name
    prefix  = "celery"
    enabled = true
  }
  tags ={
    Name            = "${var.app_name}-${var.environment}-celery-lb"

    VantaOwner  = "antonio@workera.ai"
    VantaNonProd  = false
    VantaDescription  = "${var.app_name}-${var.environment}-celery-lb"
    VantaContainsUserData  = false
  }



}
###########################################
# Target Group No1
###########################################
resource "aws_lb_target_group" "tg_celery_1" {
  name                          = "${var.app_name}-${var.environment}-tg-celery-1"
  tags= {
    Name                        = "${var.app_name}-${var.environment}-tg-celery-1"
  }
  port                          = var.alb_tg_port_celery
  protocol                      = var.alb_tg_protocol_celery
  vpc_id                        = var.vpc_id
  deregistration_delay          = var.deregistration_delay
  health_check {
    healthy_threshold           = 3
    unhealthy_threshold         = 10
    timeout                     = 5
    interval                    = 10

    path                        = var.alb_tg_path_celery
    matcher                     = var.alb_tg_code_celery
  }

}
###########################################
# Target Group No2
###########################################
resource "aws_lb_target_group" "tg_celery_2" {
  name                          = "${var.app_name}-${var.environment}-tg-celery-2"
  tags= {
    Name                        = "${var.app_name}-${var.environment}-tg-celery-2"
  }
  port                          = var.alb_tg_port_celery
  protocol                      = var.alb_tg_protocol_celery
  vpc_id                        = var.vpc_id
  deregistration_delay          = var.deregistration_delay
  health_check {
    healthy_threshold           = 3
    unhealthy_threshold         = 10
    timeout                     = 5
    interval                    = 10
    path                        = var.alb_tg_path_celery
    matcher                     = var.alb_tg_code_celery
  }

}
###########################################
# HTTP - Listener
###########################################
resource "aws_alb_listener" "alb_celery_listener_http" {
  load_balancer_arn  	        = aws_alb.celery.arn
  port               		      = "80"
  protocol           		      = "HTTP"

  default_action {
    type 			                = "redirect"

  redirect {
      port        		        = "443"
      protocol    		        = "HTTPS"
      status_code 		        = "HTTP_301"
  }
  }
  depends_on                  = [aws_alb.celery]

}
###########################################
# HTTPS - Listener
###########################################
resource "aws_alb_listener" "alb_celery_listener_https" {
  load_balancer_arn   = aws_alb.celery.arn
  port                = "443"
  protocol            = "HTTPS"
  ssl_policy          = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn     = var.certificate


  default_action {
    target_group_arn  = aws_lb_target_group.tg_celery_1.id
	  type              = "forward"
  }
  depends_on          = [aws_alb.celery]
  lifecycle {
    ignore_changes = all
  }
}