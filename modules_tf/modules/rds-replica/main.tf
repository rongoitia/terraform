#######################
# DB Subnet Group
#######################
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.environment}-${var.app_name}-db-subnet-group"
  subnet_ids  = var.db_subnet_group_list

  tags = {
    Name      = "${var.environment}-${var.app_name}-db-subnet-group"
  }
}

#######################
# DB Parameter Group
#######################
resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "${var.environment}-${var.app_name}-db-parameter-group"
  family = var.family_parameter_group

  tags = {
       Name               = "${var.environment}-${var.app_name}-db-parameter-group"
  }
}

#######################
# Postgres - RDS
#######################
resource "aws_db_instance" "postgres" {
  identifier              = var.identifier
  #allocated_storage       = var.allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  #engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  #name                    = var.db_name
  username                = var.db_username
  #password                = var.db_password
  publicly_accessible     = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  backup_window		        = var.backup_window
  maintenance_window      = var.maintenance_window
  storage_type            = var.storage_type
  max_allocated_storage   = var.max_allocated_storage
  parameter_group_name    = aws_db_parameter_group.db_parameter_group.name
  skip_final_snapshot     = var.skip_final_snapshot
  #snapshot_identifies    = var.snapshot_identifies
  snapshot_identifier     = var.snapshot_identifier
  #availability_zone       = var.availability_zone
  storage_encrypted       = var.storage_encrypted
  vpc_security_group_ids  = var.security_group_id
  multi_az                = var.multi_az
  # This value is static, do not modify
  # monitoring_interval     = 5
  # monitoring_role_arn     = aws_iam_policy.rds-monitoring.arn
  ca_cert_identifier      = "rds-ca-2019"
  iam_database_authentication_enabled   = true

  tags = {
       Name               = "${var.environment}-${var.app_name}-rds"
  }

  # depends_on              = [aws_iam_policy.rds-monitoring]
}


# resource "aws_iam_policy" "rds-monitoring" {
#   name = "${var.environment}-${var.app_name}-rds-monitoring"

#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "EnableCreationAndManagementOfRDSCloudwatchLogGroups",
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogGroup",
#                 "logs:PutRetentionPolicy"
#             ],
#             "Resource": [
#                 "arn:aws:logs:*:*:log-group:RDS*"
#             ]
#         },
#         {
#             "Sid": "EnableCreationAndManagementOfRDSCloudwatchLogStreams",
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogStream",
#                 "logs:PutLogEvents",
#                 "logs:DescribeLogStreams",
#                 "logs:GetLogEvents"
#             ],
#             "Resource": [
#                 "arn:aws:logs:*:*:log-group:RDS*:log-stream:*"
#             ]
#         }
#       ],
#       "ManagedPolicyArns": [
#           "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
#       ]
#     })
# }