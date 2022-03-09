### ECS Service Variables
variable "environment" {
   description = "Set environment name"
}
variable "app_name" {
   description = "Set app name"
}
variable "name" {
   description = "Set app name"
}
variable "service_role_name" {
  description    = "Set the Service IAM role"
}


variable "ecs_cluster_name_backend" {
  description    = "Set Cluster variable"
}
variable "task_definition_arn_backend" {
  description    = "Set a Task definition arn"
}
variable "desired_task_backend" {
  description    = "Set the desired containers"
}
variable "target_group_arn_backend_1" {
  description    = "Set the target group ARN"
}
variable "container_port_backend" {
  description    = "Set the container port"
}


variable "ecs_cluster_name_odoo" {
  description    = "Set Cluster variable"
}
variable "task_definition_arn_odoo" {
  description    = "Set a Task definition arn"
}
variable "desired_task_odoo" {
  description    = "Set the desired containers"
}
variable "target_group_arn_odoo_1" {
  description    = "Set the target group ARN"
}
variable "container_port_odoo" {
  description    = "Set the container port"
}

# #MATCHING
# variable "ecs_cluster_name_matching" {
#   description    = "Set Cluster variable"
# }
# variable "task_definition_arn_matching" {
#   description    = "Set a Task definition arn"
# }
# variable "desired_task_matching" {
#   description    = "Set the desired containers"
# }
# variable "target_group_arn_matching_1" {
#   description    = "Set the target group ARN"
# }
# variable "container_port_matching" {
#   description    = "Set the container port"
# }

#CELERY

variable "ecs_cluster_name_celery" {
  description    = "Set Cluster variable"
}
variable "task_definition_arn_celery" {
  description    = "Set a Task definition arn"
}
variable "desired_task_celery" {
  description    = "Set the desired containers"
}
variable "target_group_arn_celery_1" {
  description    = "Set the target group ARN"
}
variable "container_port_celery" {
  description    = "Set the container port"
}
