variable "environment" {
   description = "Set environment name"
}
variable "app_name" {
   description = "Set app name"
}
variable "region" {
   description = "Set app name"
}
variable "sns_cloudwatch_alarms_arn" {
   description = "Set sns arn"
}
variable "alb_backend_arn_suffix" {
   description = "Set alb id"
}
variable "alb_odoo_arn_suffix" {
   description = "Set alb id"
}
# variable "alb_matching_arn_suffix" {
#    description = "Set alb id"
# }
variable "alb_celery_arn_suffix" {
   description = "Set alb id"
}
