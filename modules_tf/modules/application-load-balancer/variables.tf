### Application Load Balancer Variables
variable "subnets" {
  description    = "Subnets that will be used by the ALB"
}
variable "alb_security_group" {
  description    = "Security Group that will be used by the ALB"
}
variable "idle_timeout" {
  description    = "Set idle timeout"
}
variable "app_name" {
  description    = "Set app name"
}
variable "environment" {
  description    = "Set environment"
}
variable "certificate" {
  description    = "Set a certificate for the Listener"
}
variable "vpc_id" {
  description    = "Trust VPC Id"
}
variable "deregistration_delay" {
  description    = "Set deregistration delay"
}
variable "main_domain" {
  description    = "Set default domain for rule"
}
variable "frontend_subdomain" {
  description    = "Set default frontend subdomain for rule"
}
variable "s3_access_log_name" {
  description    = "Set s3 bucket"
}



# Target Group odoo
variable "alb_tg_port_odoo" {
  description    = "Set a port for target group"
}
variable "alb_tg_protocol_odoo" {
  description    = "Set a protocol for target group"
}
variable "alb_tg_path_odoo" {
  description    = "Set a protocol for target group"
}
variable "alb_tg_code_odoo" {
  description    = "Set a status code for target group"
}

# # Target Group matching
# variable "alb_tg_port_matching" {
#   description    = "Set a port for target group"
# }
# variable "alb_tg_protocol_matching" {
#   description    = "Set a protocol for target group"
# }
# variable "alb_tg_path_matching" {
#   description    = "Set a protocol for target group"
# }
# variable "alb_tg_code_matching" {
#   description    = "Set a status code for target group"
# }

# Target Group backend
variable "alb_tg_port_backend" {
  description    = "Set a port for target group"
}
variable "alb_tg_protocol_backend" {
  description    = "Set a protocol for target group"
}
variable "alb_tg_path_backend" {
  description    = "Set a protocol for target group"
}
variable "alb_tg_code_backend" {
  description    = "Set a status code for target group"
}

# Target Group celery
variable "alb_tg_port_celery" {
  description    = "Set a port for target group"
}
variable "alb_tg_protocol_celery" {
  description    = "Set a protocol for target group"
}
variable "alb_tg_path_celery" {
  description    = "Set a protocol for target group"
}
variable "alb_tg_code_celery" {
  description    = "Set a status code for target group"
}



