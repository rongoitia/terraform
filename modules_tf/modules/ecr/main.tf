###########################################
# ECR
###########################################
resource "aws_ecr_repository" "odoo" {
  name                = "${var.environment}-${var.app_name}-odoo"
  image_scanning_configuration {
    scan_on_push      = var.scan_image
  }
  tags ={
    Name    = "${var.app_name}-${var.environment}-odoo-ecr"
  }

}


resource "aws_ecr_repository" "matching" {
  name                = "${var.environment}-${var.app_name}-matching"
  image_scanning_configuration {
    scan_on_push      = var.scan_image
  }
  tags ={
    Name    = "${var.app_name}-${var.environment}-matching-ecr"
  }
}

resource "aws_ecr_repository" "backend" {
  name                = "${var.environment}-${var.app_name}-backend"
  image_scanning_configuration {
    scan_on_push      = var.scan_image
  }
  tags ={
    Name    = "${var.app_name}-${var.environment}-backend-ecr"
  }
}

resource "aws_ecr_lifecycle_policy" "odoo_policy" {
  repository = aws_ecr_repository.odoo.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 15 days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 15
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "matching_policy" {
  repository = aws_ecr_repository.matching.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 15 days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 15
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "backend_policy" {
  repository = aws_ecr_repository.backend.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}