# resource "aws_flow_log" "flow_log" {
#   iam_role_arn    = aws_iam_role.role_flow_log.arn
#   log_destination = aws_cloudwatch_log_group.log_group_flow_log.arn
#   traffic_type    = "Accept"
#   vpc_id          = "${var.vpc_id}"
# }

# resource "aws_cloudwatch_log_group" "log_group_flow_log" {
#   name = "${var.app_name}-${var.environment}-log-group-vpc-flow"
# }

# resource "aws_iam_role" "role_flow_log" {
#   name = "${var.app_name}-${var.environment}-role-vpc-flow"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "vpc-flow-logs.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "policy_flow_log" {
#   name = "${var.app_name}-${var.environment}-policy-vpc-flow"
#   role = aws_iam_role.role_flow_log.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents",
#         "logs:DescribeLogGroups",
#         "logs:DescribeLogStreams"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = aws_s3_bucket.vpc_flow_log_s3.arn
  log_destination_type = "s3"
  traffic_type         = "ACCEPT"
  vpc_id               = "${var.vpc_id}"
}

resource "aws_s3_bucket" "vpc_flow_log_s3" {
  bucket = "${var.app_name}-${var.environment}-vpc-flow"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }
}