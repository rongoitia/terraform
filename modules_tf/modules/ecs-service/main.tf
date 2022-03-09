###########################################
# ECS Service BACKEND
###########################################
resource "aws_ecs_service" "backend" {
  name                          	    = "${var.name}-service-backend"
  cluster         			              = var.ecs_cluster_name_backend
  task_definition 			              = var.task_definition_arn_backend
  desired_count   			              = var.desired_task_backend
  iam_role 				                    = var.service_role_name
  ordered_placement_strategy {
    type  				                    = "spread"
    field				                      = "attribute:ecs.availability-zone"
  }
    ordered_placement_strategy {
    type  				                    = "spread"
    field				                      = "instanceId"
  }
  load_balancer {
    target_group_arn 			            = var.target_group_arn_backend_1
    container_name   			            = "backend"
    container_port   			            = var.container_port_backend
  }
  deployment_controller {
    type                              = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = all
  }

}

resource "aws_appautoscaling_target" "autoscaling_backend" {
  depends_on = [aws_ecs_service.backend]
  max_capacity       = 10
  min_capacity       = var.desired_task_backend
  resource_id        = "service/${var.ecs_cluster_name_backend}/${aws_ecs_service.backend.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "autoscaling_policy_cpu_backend" {
  name               = "ECSService-${aws_ecs_service.backend.name}-CPU"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_backend.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_backend.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_backend.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 75
    scale_in_cooldown = 60
    scale_out_cooldown = 30

    customized_metric_specification {
      metric_name = "CPUUtilization"
      namespace   = "AWS/ECS"
      statistic   = "Average"
      unit        = "Percent"
    }
  }
}

resource "aws_appautoscaling_policy" "autoscaling_policy_memory_backend" {
  name               = "ECSService-${aws_ecs_service.backend.name}-MEMORY"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_backend.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_backend.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_backend.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 90
    scale_in_cooldown = 60
    scale_out_cooldown = 30

    customized_metric_specification {
      metric_name = "MemoryUtilization"
      namespace   = "AWS/ECS"
      statistic   = "Average"
      unit        = "Percent"
    }
  }
}

###########################################
# ECS Service ODOO
###########################################
resource "aws_ecs_service" "odoo" {
  name                          	    = "${var.name}-service-odoo"
  cluster         			              = var.ecs_cluster_name_odoo
  task_definition 			              = var.task_definition_arn_odoo
  desired_count   			              = var.desired_task_odoo
  iam_role 				                    = var.service_role_name
  ordered_placement_strategy {
    type  				                    = "spread"
    field				                      = "attribute:ecs.availability-zone"
  }
    ordered_placement_strategy {
    type  				                    = "spread"
    field				                      = "instanceId"
  }
  load_balancer {
    target_group_arn 			            = var.target_group_arn_odoo_1
    container_name   			            = "odoo"
    container_port   			            = var.container_port_odoo
  }
  deployment_controller {
    type                              = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = all
  }

}

resource "aws_appautoscaling_target" "autoscaling_odoo" {
  depends_on = [aws_ecs_service.odoo]
  max_capacity       = 10
  min_capacity       = var.desired_task_odoo
  resource_id        = "service/${var.ecs_cluster_name_odoo}/${aws_ecs_service.odoo.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "autoscaling_policy_cpu_odoo" {
  name               = "ECSService-${aws_ecs_service.odoo.name}-CPU"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_odoo.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_odoo.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_odoo.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 75
    scale_in_cooldown = 60
    scale_out_cooldown = 30

    customized_metric_specification {
      metric_name = "CPUUtilization"
      namespace   = "AWS/ECS"
      statistic   = "Average"
      unit        = "Percent"
    }
  }
}

resource "aws_appautoscaling_policy" "autoscaling_policy_memory_odoo" {
  name               = "ECSService-${aws_ecs_service.odoo.name}-MEMORY"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_odoo.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_odoo.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_odoo.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 90
    scale_in_cooldown = 60
    scale_out_cooldown = 30

    customized_metric_specification {
      metric_name = "MemoryUtilization"
      namespace   = "AWS/ECS"
      statistic   = "Average"
      unit        = "Percent"
    }
  }
}


# ###########################################
# # ECS Service Matching
# ###########################################
# resource "aws_ecs_service" "matching" {
#   name                          	    = "${var.name}-service-matching"
#   cluster         			              = var.ecs_cluster_name_matching
#   task_definition 			              = var.task_definition_arn_matching
#   desired_count   			              = var.desired_task_matching
#   iam_role 				                    = var.service_role_name
#   ordered_placement_strategy {
#     type  				                    = "spread"
#     field				                      = "attribute:ecs.availability-zone"
#   }
#     ordered_placement_strategy {
#     type  				                    = "spread"
#     field				                      = "instanceId"
#   }
#   load_balancer {
#     target_group_arn 			            = var.target_group_arn_matching_1
#     container_name   			            = "matching"
#     container_port   			            = var.container_port_matching
#   }
#   deployment_controller {
#     type                              = "CODE_DEPLOY"
#   }

#   lifecycle {
#     ignore_changes = all
#   }

# }

# resource "aws_appautoscaling_target" "autoscaling_matching" {
#   depends_on = [aws_ecs_service.matching]
#   max_capacity       = 10
#   min_capacity       = var.desired_task_matching
#   resource_id        = "service/${var.ecs_cluster_name_matching}/${aws_ecs_service.matching.name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
# }

# resource "aws_appautoscaling_policy" "autoscaling_policy_cpu_matching" {
#   name               = "ECSService-${aws_ecs_service.matching.name}-CPU"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.autoscaling_matching.resource_id
#   scalable_dimension = aws_appautoscaling_target.autoscaling_matching.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.autoscaling_matching.service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value = 75
#     scale_in_cooldown = 60
#     scale_out_cooldown = 30

#     customized_metric_specification {
#       metric_name = "CPUUtilization"
#       namespace   = "AWS/ECS"
#       statistic   = "Average"
#       unit        = "Percent"
#     }
#   }
# }

# resource "aws_appautoscaling_policy" "autoscaling_policy_memory_matching" {
#   name               = "ECSService-${aws_ecs_service.matching.name}-MEMORY"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.autoscaling_matching.resource_id
#   scalable_dimension = aws_appautoscaling_target.autoscaling_matching.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.autoscaling_matching.service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value = 90
#     scale_in_cooldown = 60
#     scale_out_cooldown = 30

#     customized_metric_specification {
#       metric_name = "MemoryUtilization"
#       namespace   = "AWS/ECS"
#       statistic   = "Average"
#       unit        = "Percent"
#     }
#   }
# }

###########################################
# ECS Service Celery
###########################################
resource "aws_ecs_service" "celery" {
  name                          	    = "${var.name}-service-celery"
  cluster         			              = var.ecs_cluster_name_celery
  task_definition 			              = var.task_definition_arn_celery
  desired_count   			              = var.desired_task_celery
  iam_role 				                    = var.service_role_name
  ordered_placement_strategy {
    type  				                    = "spread"
    field				                      = "attribute:ecs.availability-zone"
  }
    ordered_placement_strategy {
    type  				                    = "spread"
    field				                      = "instanceId"
  }
  load_balancer {
    target_group_arn 			            = var.target_group_arn_celery_1
    container_name   			            = "celery"
    container_port   			            = var.container_port_celery
  }
  deployment_controller {
    type                              = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = all
  }

}

resource "aws_appautoscaling_target" "autoscaling_celery" {
  depends_on = [aws_ecs_service.celery]
  max_capacity       = 10
  min_capacity       = var.desired_task_celery
  resource_id        = "service/${var.ecs_cluster_name_celery}/${aws_ecs_service.celery.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "autoscaling_policy_cpu_celery" {
  name               = "ECSService-${aws_ecs_service.celery.name}-CPU"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_celery.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_celery.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_celery.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 75
    scale_in_cooldown = 60
    scale_out_cooldown = 30

    customized_metric_specification {
      metric_name = "CPUUtilization"
      namespace   = "AWS/ECS"
      statistic   = "Average"
      unit        = "Percent"
    }
  }
}

resource "aws_appautoscaling_policy" "autoscaling_policy_memory_celery" {
  name               = "ECSService-${aws_ecs_service.celery.name}-MEMORY"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_celery.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_celery.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_celery.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 90
    scale_in_cooldown = 60
    scale_out_cooldown = 30

    customized_metric_specification {
      metric_name = "MemoryUtilization"
      namespace   = "AWS/ECS"
      statistic   = "Average"
      unit        = "Percent"
    }
  }
}