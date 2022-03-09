##############################
#  DATABASE
##############################
resource "aws_codebuild_project" "database" {
  name                          = "${var.environment}-${var.app_name}-db"
  service_role                  = var.codebuild_role_arn
  description                   = "${var.environment}-${var.app_name}-db"
  build_timeout                 = "30"
  queued_timeout                = "180"

  source {
    type                        = "GITHUB"
    location                    = var.repo_db_url
    git_clone_depth             = 0
    #buildspec                  = var.buildspec
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.codebuild_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name                      = "ENV_NAME"
      value                     = var.environment
    }
    environment_variable {
      name                      = "ENV_REGION"
      value                     = var.region
    }
    environment_variable {
      name                      = "NAME_ODOO_SECRET"
      value                     = var.secret_odoo_name
    }
    environment_variable {
      name                      = "NAME_SECRET_ENV"
      value                     = var.secret_env_name
    }
    environment_variable {
      name                      = "NAME_BACKEND_SECRET"
      value                     = var.secret_backend_name
    }
      environment_variable {
      name                      = "BUCKET_ENV"
      value                     = "${replace(var.environment, "/-.*/", "")}"
    }
    environment_variable {
      name                      = "NAME_DB_SECRET"
      value                     = var.secret_db_name
    }
  }
  vpc_config {
    vpc_id                      = var.vpc_id

    subnets                     = var.codebuild_subnets

    security_group_ids          = var.codebuild_security_group
  }

  logs_config {
    cloudwatch_logs {
      status                    = "ENABLED"
    }
  }

  artifacts {
    type                        = "NO_ARTIFACTS"
  }
}


##############################
#  FRONTEND
##############################
resource "aws_codebuild_project" "frontend" {
  name                          = "${var.environment}-${var.app_name}-frontend"
  service_role                  = var.codebuild_role_arn
  description                   = "${var.environment}-${var.app_name}-frontend"
  build_timeout                 = "30"
  queued_timeout                = "180"

  source {
    type                        = "GITHUB"
    location                    = var.repo_frontend_url
    git_clone_depth             = 0
    #buildspec                  = var.buildspec
    git_submodules_config {
      fetch_submodules          = true
    }
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.codebuild_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name                      = "ENV_NAME"
      value                     = var.environment
    }
    environment_variable {
      name                      = "ARN_SECRET"
      value                     = var.secret_frontend_arn
    }
    environment_variable {
      name                      = "NAME_SECRET"
      value                     = var.secret_frontend_name
    }
    environment_variable {
      name                      = "ARN_SECRET_ENV"
      value                     = var.secret_env_arn
    }
    environment_variable {
      name                      = "NAME_SECRET_ENV"
      value                     = var.secret_env_name
    }
    environment_variable {
      name                      = "ENV_REGION"
      value                     = var.region
    }
    environment_variable {
      name                      = "CLOUDFRONT_ID"
      value                     = var.cloudfront_frontend_id
    }
  }

  vpc_config {
    vpc_id                      = var.vpc_id

    subnets                     = var.codebuild_subnets

    security_group_ids          = var.codebuild_security_group
  }

  logs_config {
    cloudwatch_logs {
      status                    = "ENABLED"
    }
  }

  artifacts {
    type                        = "NO_ARTIFACTS"
  }
}

##############################
#  BACKEND
##############################
resource "aws_codebuild_project" "backend" {
  name                          = "${var.environment}-${var.app_name}-backend"
  service_role                  = var.codebuild_role_arn
  description                   = "${var.environment}-${var.app_name}-backend"
  build_timeout                 = "30"
  queued_timeout                = "180"

  source {
    type                        = "GITHUB"
    location                    = var.repo_backend_url
    git_clone_depth             = 0
    #buildspec                  = var.buildspec
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.codebuild_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name                      = "ENV_NAME"
      value                     = var.environment
    }
    environment_variable {
      name                      = "ARN_SECRET_ENV"
      value                     = var.secret_env_arn
    }
    environment_variable {
      name                      = "ARN_SECRET"
      value                     = var.secret_backend_arn
    }
    environment_variable {
      name                      = "ENV_REGION"
      value                     = var.region
    }
    environment_variable {
      name                      = "TASK_DEF"
      value                     = var.taskdef_file
    }
    environment_variable {
      name                      = "TASK_DEF_CELERY"
      value                     = "taskdef_celery.json"
    }
  }

  vpc_config {
    vpc_id                      = var.vpc_id

    subnets                     = var.codebuild_subnets

    security_group_ids          = var.codebuild_security_group
  }

  logs_config {
    cloudwatch_logs {
      status                    = "ENABLED"
    }
  }

  artifacts {
    type                        = "NO_ARTIFACTS"
  }
}

##############################
#  ODOO
##############################
resource "aws_codebuild_project" "odoo" {
  name                          = "${var.environment}-${var.app_name}-odoo"
  service_role                  = var.codebuild_role_arn
  description                   = "${var.environment}-${var.app_name}-odoo"
  build_timeout                 = "30"
  queued_timeout                = "180"

  source {
    type                        = "GITHUB"
    location                    = var.repo_odoo_url
    git_clone_depth             = 0
    #buildspec                  = var.buildspec
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.codebuild_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name                      = "ENV_NAME"
      value                     = var.environment
    }
    environment_variable {
      name                      = "EFS_ID"
      value                     = var.efs_odoo_id
    }
    environment_variable {
      name                      = "ARN_SECRET"
      value                     = var.secret_odoo_arn
    }
    environment_variable {
      name                      = "NAME_SECRET"
      value                     = var.secret_odoo_name
    }
    environment_variable {
      name                      = "ARN_SECRET_ENV"
      value                     = var.secret_env_arn
    }
    environment_variable {
      name                      = "NAME_SECRET_ENV"
      value                     = var.secret_env_name
    }
    environment_variable {
      name                      = "ENV_REGION"
      value                     = var.region
    }
    environment_variable {
      name                      = "TASK_DEF"
      value                     = var.taskdef_file
    }
  }

  vpc_config {
    vpc_id                      = var.vpc_id

    subnets                     = var.codebuild_subnets

    security_group_ids          = var.codebuild_security_group
  }

  logs_config {
    cloudwatch_logs {
      status                    = "ENABLED"
    }
  }

  artifacts {
    type                        = "NO_ARTIFACTS"
  }
}

# ##############################
# #  MATCHING
# ##############################
# resource "aws_codebuild_project" "matching" {
#   name                          = "${var.environment}-${var.app_name}-matching"
#   service_role                  = var.codebuild_role_arn
#   description                   = "${var.environment}-${var.app_name}-matching"
#   build_timeout                 = "30"
#   queued_timeout                = "180"

#   source {
#     type                        = "GITHUB"
#     location                    = var.repo_matching_url
#     git_clone_depth             = 0
#     #buildspec                  = var.buildspec
#   }

#   environment {
#     compute_type                = "BUILD_GENERAL1_SMALL"
#     image                       = var.codebuild_image
#     type                        = "LINUX_CONTAINER"
#     image_pull_credentials_type = "CODEBUILD"
#     privileged_mode             = true

#     environment_variable {
#       name                      = "ENV_NAME"
#       value                     = var.environment
#     }
#     environment_variable {
#       name                      = "ARN_SECRET"
#       value                     = var.secret_matching_arn
#     }
#     environment_variable {
#       name                      = "ARN_SECRET_ENV"
#       value                     = var.secret_env_arn
#     }
#     environment_variable {
#       name                      = "ENV_REGION"
#       value                     = var.region
#     }
#     environment_variable {
#       name                      = "TASK_DEF"
#       value                     = var.taskdef_file
#     }
#   }

#   vpc_config {
#     vpc_id                      = var.vpc_id

#     subnets                     = var.codebuild_subnets

#     security_group_ids          = var.codebuild_security_group
#   }

#   logs_config {
#     cloudwatch_logs {
#       status                    = "ENABLED"
#     }
#   }

#   artifacts {
#     type                        = "NO_ARTIFACTS"
#   }
# }
