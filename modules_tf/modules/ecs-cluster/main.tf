###########################################
# ECS Clusters
###########################################
resource "aws_ecs_cluster" "backend" {
  name 				        = var.backend
  #capacity_providers  = ["backend-cp"]
  setting {
    name              = "containerInsights"
    value             = "enabled"
  }
}

resource "aws_ecs_cluster" "odoo" {
  name 				        = var.odoo
  #capacity_providers  = ["odoo-cp"]
  setting {
    name              = "containerInsights"
    value             = "enabled"
  }
}

# resource "aws_ecs_cluster" "matching" {
#   name 				        = var.matching
#   #capacity_providers  = ["matching-cp"]
#   setting {
#     name              = "containerInsights"
#     value             = "enabled"
#   }
# }

resource "aws_ecs_cluster" "celery" {
  name 				        = var.celery
  #capacity_providers  = ["matching-cp"]
  setting {
    name              = "containerInsights"
    value             = "enabled"
  }
}

