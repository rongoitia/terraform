### CodeDeploy Variables
variable "environment" {
   description = "Set environment name"
}
variable "app_name" {
   description = "Set app name"
}
variable "name" {
   description = "Set app name"
}
variable "codedeploy_role_arn" {
  description    = "Set the arn IAM role"
}


variable "ecs_service_backend" {
  description    = "Set the name of service"
}
variable "ecs_cluster_name_backend" {
  description    = "Set Cluster variable"
}
variable "listener_arn_backend" {
  description    = "Set a alb listener arn"
}
variable "target_group_name_backend_1" {
  description    = "Set the name of targer group"
}
variable "target_group_name_backend_2" {
  description    = "Set the name of targer group"
}


variable "ecs_service_odoo" {
  description    = "Set the name of service"
}
variable "ecs_cluster_name_odoo" {
  description    = "Set Cluster variable"
}
variable "listener_arn_odoo" {
  description    = "Set a alb listener arn"
}
variable "target_group_name_odoo_1" {
  description    = "Set the name of targer group"
}
variable "target_group_name_odoo_2" {
  description    = "Set the name of targer group"
}


# variable "ecs_service_matching" {
#   description    = "Set the name of service"
# }
# variable "ecs_cluster_name_matching" {
#   description    = "Set Cluster variable"
# }
# variable "listener_arn_matching" {
#   description    = "Set a alb listener arn"
# }
# variable "target_group_name_matching_1" {
#   description    = "Set the name of targer group"
# }
# variable "target_group_name_matching_2" {
#   description    = "Set the name of targer group"
# }


variable "ecs_service_celery" {
  description    = "Set the name of service"
}
variable "ecs_cluster_name_celery" {
  description    = "Set Cluster variable"
}
variable "listener_arn_celery" {
  description    = "Set a alb listener arn"
}
variable "target_group_name_celery_1" {
  description    = "Set the name of targer group"
}
variable "target_group_name_celery_2" {
  description    = "Set the name of targer group"
}