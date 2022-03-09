resource "aws_iam_role" "audit_role" {
  name = "${var.app_name}-${var.environment}-audit-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.audit_account_id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.audit_external_id}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "audit_policy" {
  name        = "${var.app_name}-${var.environment}-audit-policy"
  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "ecr:DescribeImageScanFindings",
            "ecr:DescribeImages",
            "dynamodb:ListTagsOfResource",
            "ecr:ListTagsForResource",
            "sqs:ListQueueTags"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Deny",
        "Action": [
            "datapipeline:EvaluateExpression",
            "datapipeline:QueryObjects",
            "rds:DownloadDBLogFilePortion"
        ],
        "Resource": "*"
    }
]
}
EOF
}

resource "aws_iam_role_policy_attachment" "audit_att_policy" {
  role       = aws_iam_role.audit_role.name
  policy_arn = aws_iam_policy.audit_policy.arn
}


resource "aws_iam_role_policy_attachment" "audit_att_policy2" {
  role       = aws_iam_role.audit_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}




