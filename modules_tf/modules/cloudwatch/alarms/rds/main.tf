resource "aws_cloudwatch_metric_alarm" "rds_CPUUtilization" {

  alarm_name                = "${var.app_name}-${var.environment}-rds-CPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "70"
  alarm_description         = "This metric monitors RDS cpu utilization"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_cloudwatch_alarms_arn]
  ok_actions                = [var.sns_cloudwatch_alarms_arn]

  dimensions                = {
    "DBInstanceIdentifier"  = var.rds_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_DBConnections" {

  alarm_name                = "${var.app_name}-${var.environment}-rds-DBConnections"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "DatabaseConnections"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "35"
  alarm_description         = "This metric monitors RDS database connections"
  datapoints_to_alarm       = 2
  insufficient_data_actions = []
  alarm_actions             = [var.sns_cloudwatch_alarms_arn]
  ok_actions                = [var.sns_cloudwatch_alarms_arn]

  dimensions                = {
    "DBInstanceIdentifier"  = var.rds_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_FreeStorageSpace" {

  alarm_name                = "${var.app_name}-${var.environment}-rds-FreeStorageSpace"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "15"
  metric_name               = "FreeStorageSpace"
  namespace                 = "AWS/RDS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "50000000000"
  alarm_description         = "This metric monitors RDS free storage space"
  datapoints_to_alarm       = 1
  insufficient_data_actions = []
  alarm_actions             = [var.sns_cloudwatch_alarms_arn]
  ok_actions                = [var.sns_cloudwatch_alarms_arn]

  dimensions                = {
    "DBInstanceIdentifier"  = var.rds_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_FreeableMemory" {

  alarm_name                = "${var.app_name}-${var.environment}-rds-FreeableMemory"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "5"
  metric_name               = "FreeableMemory"
  namespace                 = "AWS/RDS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = var.rds_memory_min
  alarm_description         = "This metric monitors RDS freeable memory"
  datapoints_to_alarm       = 3
  insufficient_data_actions = []
  alarm_actions             = [var.sns_cloudwatch_alarms_arn]
  ok_actions                = [var.sns_cloudwatch_alarms_arn]

  dimensions                = {
    "DBInstanceIdentifier"  = var.rds_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_DiskQueueDepth" {

  alarm_name                = "${var.app_name}-${var.environment}-rds-DiskQueueDepth"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "10"
  metric_name               = "DiskQueueDepth"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "4"
  alarm_description         = "This metric monitors RDS Disk Queue Depth"
  datapoints_to_alarm       = 10
  insufficient_data_actions = []
  alarm_actions             = [var.sns_cloudwatch_alarms_arn]
  ok_actions                = [var.sns_cloudwatch_alarms_arn]

  dimensions                = {
    "DBInstanceIdentifier"  = var.rds_id
  }
}