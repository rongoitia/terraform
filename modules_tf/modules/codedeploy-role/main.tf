resource "aws_iam_role" "codedeploy_role" {
  name = "${var.name}-codedeploy-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "codedeploy_policy" {
  name        = "${var.name}-codedeploy-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [
              "ecs:DescribeServices",
              "ecs:CreateTaskSet",
              "ecs:UpdateServicePrimaryTaskSet",
              "ecs:DeleteTaskSet",
              "elasticloadbalancing:DescribeTargetGroups",
              "elasticloadbalancing:DescribeListeners",
              "elasticloadbalancing:ModifyListener",
              "elasticloadbalancing:DescribeRules",
              "elasticloadbalancing:ModifyRule",
              "lambda:InvokeFunction",
              "cloudwatch:DescribeAlarms",
              "sns:Publish",
              "s3:GetObject",
              "s3:GetObjectVersion"
          ],
          "Resource": "*",
          "Effect": "Allow"
        },
        {
          "Action": [
              "iam:PassRole"
          ],
          "Effect": "Allow",
          "Resource": "*",
          "Condition": {
              "StringLike": {
                  "iam:PassedToService": [
                      "ecs-tasks.amazonaws.com"
                  ]
              }
          }
        },
        {
          "Effect":"Allow",
          "Action": [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketVersioning",
            "s3:PutObject"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "codebuild:BatchGetBuilds",
            "codebuild:StartBuild"
          ],
          "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codedeploy_att_policy" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = aws_iam_policy.codedeploy_policy.arn
}




