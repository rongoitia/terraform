##############################
# Backend
##############################
resource "aws_codedeploy_app" "cp_backend" {
  compute_platform                      = "ECS"
  name                                  = "${var.name}-app-backend"
}

resource "aws_codedeploy_deployment_group" "cdg_backend" {
  app_name                              = aws_codedeploy_app.cp_backend.name
  deployment_config_name                = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name                 = "${var.name}-deployment-backend"
  service_role_arn                      = var.codedeploy_role_arn

  auto_rollback_configuration {
    enabled                             = true
    events                              = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout                 = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                            = "TERMINATE"
      termination_wait_time_in_minutes  = 0
    }
  }

  deployment_style {
    deployment_option                   = "WITH_TRAFFIC_CONTROL"
    deployment_type                     = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name                        = var.ecs_cluster_name_backend
    service_name                        = var.ecs_service_backend
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns                   = [var.listener_arn_backend]
      }

      target_group {
        name                            = var.target_group_name_backend_1
      }

      target_group {
        name                            = var.target_group_name_backend_2
      }
    }
  }
}

##############################
# Celery
##############################
resource "aws_codedeploy_app" "cp_celery" {
  compute_platform                      = "ECS"
  name                                  = "${var.name}-app-celery"
}

resource "aws_codedeploy_deployment_group" "cdg_celery" {
  app_name                              = aws_codedeploy_app.cp_celery.name
  deployment_config_name                = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name                 = "${var.name}-deployment-celery"
  service_role_arn                      = var.codedeploy_role_arn

  auto_rollback_configuration {
    enabled                             = true
    events                              = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout                 = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                            = "TERMINATE"
      termination_wait_time_in_minutes  = 0
    }
  }

  deployment_style {
    deployment_option                   = "WITH_TRAFFIC_CONTROL"
    deployment_type                     = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name                        = var.ecs_cluster_name_celery
    service_name                        = var.ecs_service_celery
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns                   = [var.listener_arn_celery]
      }

      target_group {
        name                            = var.target_group_name_celery_1
      }

      target_group {
        name                            = var.target_group_name_celery_2
      }
    }
  }
}

##############################
# Odoo
##############################
resource "aws_codedeploy_app" "cp_odoo" {
  compute_platform                      = "ECS"
  name                                  = "${var.name}-app-odoo"
}

resource "aws_codedeploy_deployment_group" "cdg_odoo" {
  app_name                              = aws_codedeploy_app.cp_odoo.name
  deployment_config_name                = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name                 = "${var.name}-deployment-odoo"
  service_role_arn                      = var.codedeploy_role_arn

  auto_rollback_configuration {
    enabled                             = true
    events                              = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout                 = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                            = "TERMINATE"
      termination_wait_time_in_minutes  = 0
    }
  }

  deployment_style {
    deployment_option                   = "WITH_TRAFFIC_CONTROL"
    deployment_type                     = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name                        = var.ecs_cluster_name_odoo
    service_name                        = var.ecs_service_odoo
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns                   = [var.listener_arn_odoo]
      }

      target_group {
        name                            = var.target_group_name_odoo_1
      }

      target_group {
        name                            = var.target_group_name_odoo_2
      }
    }
  }
}

# ##############################
# # Matching
# ##############################
# resource "aws_codedeploy_app" "cp_matching" {
#   compute_platform                      = "ECS"
#   name                                  = "${var.name}-app-matching"
# }

# resource "aws_codedeploy_deployment_group" "cdg_matching" {
#   app_name                              = aws_codedeploy_app.cp_matching.name
#   deployment_config_name                = "CodeDeployDefault.ECSAllAtOnce"
#   deployment_group_name                 = "${var.name}-deployment-matching"
#   service_role_arn                      = var.codedeploy_role_arn

#   auto_rollback_configuration {
#     enabled                             = true
#     events                              = ["DEPLOYMENT_FAILURE"]
#   }

#   blue_green_deployment_config {
#     deployment_ready_option {
#       action_on_timeout                 = "CONTINUE_DEPLOYMENT"
#     }

#     terminate_blue_instances_on_deployment_success {
#       action                            = "TERMINATE"
#       termination_wait_time_in_minutes  = 0
#     }
#   }

#   deployment_style {
#     deployment_option                   = "WITH_TRAFFIC_CONTROL"
#     deployment_type                     = "BLUE_GREEN"
#   }

#   ecs_service {
#     cluster_name                        = var.ecs_cluster_name_matching
#     service_name                        = var.ecs_service_matching
#   }

#   load_balancer_info {
#     target_group_pair_info {
#       prod_traffic_route {
#         listener_arns                   = [var.listener_arn_matching]
#       }

#       target_group {
#         name                            = var.target_group_name_matching_1
#       }

#       target_group {
#         name                            = var.target_group_name_matching_2
#       }
#     }
#   }
# }