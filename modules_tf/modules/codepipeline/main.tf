resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket                      = "${var.environment}-${var.app_name}-codepipeline"
  acl                         = "private"
  force_destroy               = true
}


####################
# DB SYNC
####################
resource "aws_codepipeline" "codepipeline_db" {
  name                        = "${var.environment}-${var.app_name}-db"
  role_arn                    = var.codepipeline_role_arn

  artifact_store {
    location                  = aws_s3_bucket.codepipeline_bucket.bucket
    type                      = "S3"
  }

  stage {
    name = "Source"

    action {
      name                    = "Source"
      category                = "Source"
      owner                   = "AWS"
      provider                = "CodeStarSourceConnection"
      version                 = "1"
      output_artifacts        = ["SourceArtifact"]
      namespace               = "SourceVariables"

      configuration = {
        ConnectionArn         = var.codestar_arn
        FullRepositoryId      = var.repo_name_db
        BranchName            = var.branch_db
        OutputArtifactFormat  = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name                    = "Build"
      category                = "Build"
      owner                   = "AWS"
      provider                = "CodeBuild"
      input_artifacts         = ["SourceArtifact"]
      output_artifacts        = ["BuildArtifact"]
      namespace               = "BuildVariables"
      version                 = "1"

      configuration = {
        ProjectName           = "${var.environment}-${var.app_name}-db"
      }
    }
  }

  lifecycle {
    ignore_changes = [ stage[0] ]
  }

}


####################
# FRONTEND
####################
resource "aws_codepipeline" "codepipeline_frontend" {
  name                        = "${var.environment}-${var.app_name}-frontend"
  role_arn                    = var.codepipeline_role_arn

  artifact_store {
    location                  = aws_s3_bucket.codepipeline_bucket.bucket
    type                      = "S3"
  }

  stage {
    name = "Source"

    action {
      name                    = "Source"
      category                = "Source"
      owner                   = "AWS"
      provider                = "CodeStarSourceConnection"
      version                 = "1"
      output_artifacts        = ["SourceArtifact"]
      namespace               = "SourceVariables"

      configuration = {
        ConnectionArn         = var.codestar_arn
        FullRepositoryId      = var.repo_name_frontend
        BranchName            = var.branch_frontend
        OutputArtifactFormat  = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name                    = "Build"
      category                = "Build"
      owner                   = "AWS"
      provider                = "CodeBuild"
      input_artifacts         = ["SourceArtifact"]
      output_artifacts        = ["BuildArtifact"]
      namespace               = "BuildVariables"
      version                 = "1"

      configuration = {
        ProjectName           = "${var.environment}-${var.app_name}-frontend"
      }
    }
  }

  lifecycle {
    ignore_changes = [ stage[0] ]
  }

}

####################
# BACKEND
####################
resource "aws_codepipeline" "codepipeline_backend" {
  name                        = "${var.environment}-${var.app_name}-backend"
  role_arn                    = var.codepipeline_role_arn

  artifact_store {
    location                  = aws_s3_bucket.codepipeline_bucket.bucket
    type                      = "S3"
  }

  stage {
    name = "Source"

    action {
      name                    = "Source"
      category                = "Source"
      owner                   = "AWS"
      provider                = "CodeStarSourceConnection"
      version                 = "1"
      output_artifacts        = ["SourceArtifact"]
      namespace               = "SourceVariables"

      configuration = {
        ConnectionArn         = var.codestar_arn
        FullRepositoryId      = var.repo_name_backend
        BranchName            = var.branch_backend
        OutputArtifactFormat  = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name                    = "Build"
      category                = "Build"
      owner                   = "AWS"
      provider                = "CodeBuild"
      input_artifacts         = ["SourceArtifact"]
      output_artifacts        = ["BuildArtifact"]
      namespace               = "BuildVariables"
      version                 = "1"

      configuration = {
        ProjectName           = "${var.environment}-${var.app_name}-backend"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name                    = "Deploy"
      category                = "Deploy"
      owner                   = "AWS"
      provider                = "CodeDeployToECS"
      input_artifacts         = ["BuildArtifact"]
      namespace               = "DeployVariables"
      version                 = "1"

      configuration = {
        ApplicationName       = "${var.app_name}-${var.environment}-app-backend"
        DeploymentGroupName   = "${var.app_name}-${var.environment}-deployment-backend"
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        TaskDefinitionTemplatePath = var.taskdef_file
        AppSpecTemplateArtifact = "BuildArtifact"
        AppSpecTemplatePath   = "appspec.yaml"
      }
    }

    action {
      name                    = "Celery"
      category                = "Deploy"
      owner                   = "AWS"
      provider                = "CodeDeployToECS"
      input_artifacts         = ["BuildArtifact"]
      version                 = "1"

      configuration = {
        ApplicationName       = "${var.app_name}-${var.environment}-app-celery"
        DeploymentGroupName   = "${var.app_name}-${var.environment}-deployment-celery"
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        TaskDefinitionTemplatePath = "taskdef_celery.json"
        AppSpecTemplateArtifact = "BuildArtifact"
        AppSpecTemplatePath   = "appspec_celery.yaml"
      }
    }
  }

  lifecycle {
    ignore_changes = [ stage[0] ]
  }

}

####################
# ODOO
####################
resource "aws_codepipeline" "codepipeline_odoo" {
  name                        = "${var.environment}-${var.app_name}-odoo"
  role_arn                    = var.codepipeline_role_arn

  artifact_store {
    location                  = aws_s3_bucket.codepipeline_bucket.bucket
    type                      = "S3"
  }

  stage {
    name = "Source"

    action {
      name                    = "Source"
      category                = "Source"
      owner                   = "AWS"
      provider                = "CodeStarSourceConnection"
      version                 = "1"
      output_artifacts        = ["SourceArtifact"]
      namespace               = "SourceVariables"

      configuration = {
        ConnectionArn         = var.codestar_arn
        FullRepositoryId      = var.repo_name_odoo
        BranchName            = var.branch_odoo
        OutputArtifactFormat  = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name                    = "Build"
      category                = "Build"
      owner                   = "AWS"
      provider                = "CodeBuild"
      input_artifacts         = ["SourceArtifact"]
      output_artifacts        = ["BuildArtifact"]
      namespace               = "BuildVariables"
      version                 = "1"

      configuration = {
        ProjectName           = "${var.environment}-${var.app_name}-odoo"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name                    = "Deploy"
      category                = "Deploy"
      owner                   = "AWS"
      provider                = "CodeDeployToECS"
      input_artifacts         = ["BuildArtifact"]
      namespace               = "DeployVariables"
      version                 = "1"

      configuration = {
        ApplicationName       = "${var.app_name}-${var.environment}-app-odoo"
        DeploymentGroupName   = "${var.app_name}-${var.environment}-deployment-odoo"
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        TaskDefinitionTemplatePath = var.taskdef_file
        AppSpecTemplateArtifact = "BuildArtifact"
        AppSpecTemplatePath   = "appspec.yaml"
      }
    }
  }

  lifecycle {
    ignore_changes = [ stage[0] ]
  }
}

# ####################
# # MATCHING
# ####################
# resource "aws_codepipeline" "codepipeline_matching" {
#   name                        = "${var.environment}-${var.app_name}-matching"
#   role_arn                    = var.codepipeline_role_arn

#   artifact_store {
#     location                  = aws_s3_bucket.codepipeline_bucket.bucket
#     type                      = "S3"
#   }

#   stage {
#     name = "Source"

#     action {
#       name                    = "Source"
#       category                = "Source"
#       owner                   = "AWS"
#       provider                = "CodeStarSourceConnection"
#       version                 = "1"
#       output_artifacts        = ["SourceArtifact"]
#       namespace               = "SourceVariables"

#       configuration = {
#         ConnectionArn         = var.codestar_arn
#         FullRepositoryId      = var.repo_name_matching
#         BranchName            = var.branch_matching
#         OutputArtifactFormat  = "CODEBUILD_CLONE_REF"
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name                    = "Build"
#       category                = "Build"
#       owner                   = "AWS"
#       provider                = "CodeBuild"
#       input_artifacts         = ["SourceArtifact"]
#       output_artifacts        = ["BuildArtifact"]
#       namespace               = "BuildVariables"
#       version                 = "1"

#       configuration = {
#         ProjectName           = "${var.environment}-${var.app_name}-matching"
#       }
#     }
#   }

#   stage {
#     name = "Deploy"

#     action {
#       name                    = "Deploy"
#       category                = "Deploy"
#       owner                   = "AWS"
#       provider                = "CodeDeployToECS"
#       input_artifacts         = ["BuildArtifact"]
#       namespace               = "DeployVariables"
#       version                 = "1"

#       configuration = {
#         ApplicationName       = "${var.app_name}-${var.environment}-app-matching"
#         DeploymentGroupName   = "${var.app_name}-${var.environment}-deployment-matching"
#         TaskDefinitionTemplateArtifact = "BuildArtifact"
#         TaskDefinitionTemplatePath = var.taskdef_file
#         AppSpecTemplateArtifact = "BuildArtifact"
#         AppSpecTemplatePath   = "appspec.yaml"
#       }
#     }
#   }

#   lifecycle {
#     ignore_changes = [ stage[0] ]
#   }

# }

module "codepipeline-notifications" {
  source  = "kjagiello/codepipeline-slack-notifications/aws"
  version = "1.1.4"

  name            = "pipeline-notifications"
  namespace       = var.app_name
  stage           = var.environment
  slack_url       = "https://hooks.slack.com/services/{token}"
  slack_channel   = "#engineering_cicd_notifications"
  slack_emoji     = ":rocket:"
  codepipelines   = [
    aws_codepipeline.codepipeline_backend,
    aws_codepipeline.codepipeline_frontend,
    aws_codepipeline.codepipeline_odoo
  ]
  event_type_ids  = [
  "codepipeline-pipeline-pipeline-execution-started",
  "codepipeline-pipeline-pipeline-execution-failed",
  "codepipeline-pipeline-pipeline-execution-canceled",
  "codepipeline-pipeline-pipeline-execution-succeeded"
  ]
}