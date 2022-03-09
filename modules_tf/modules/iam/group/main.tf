resource "aws_iam_group" "admin" {
  name = "${var.app_name}-${var.environment}-admin"
}

resource "aws_iam_group" "devops" {
  name = "${var.app_name}-${var.environment}-devops"
}

resource "aws_iam_group" "developers" {
  name = "${var.app_name}-${var.environment}-developers"
}

resource "aws_iam_group" "app" {
  name = "${var.app_name}-${var.environment}-app"
}

resource "aws_iam_group" "audit" {
  name = "${var.app_name}-${var.environment}-audit"
}


resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "my_developer_policy"
  group = aws_iam_group.app.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
