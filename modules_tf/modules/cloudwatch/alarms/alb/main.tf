###################
######RequestCount
resource "aws_cloudwatch_metric_alarm" "alb_backend_request" {
  alarm_name          = "${var.app_name}-${var.environment}-alb-backend-CountRequests"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = 400
  alarm_description   = "Number of request in ALB"
  datapoints_to_alarm = 2
  alarm_actions       = [var.sns_cloudwatch_alarms_arn]
  ok_actions          = [var.sns_cloudwatch_alarms_arn]

  dimensions = {
    "LoadBalancer"     = var.alb_backend_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_odoo_request" {
  alarm_name          = "${var.app_name}-${var.environment}-alb-odoo-CountRequests"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = 400
  alarm_description   = "Number of request in ALB"
  datapoints_to_alarm = 3
  alarm_actions       = [var.sns_cloudwatch_alarms_arn]
  ok_actions          = [var.sns_cloudwatch_alarms_arn]

  dimensions = {
    "LoadBalancer"     = var.alb_odoo_arn_suffix
  }
}

# resource "aws_cloudwatch_metric_alarm" "alb_matching_request" {
#   alarm_name          = "${var.app_name}-${var.environment}-alb-matching-CountRequests"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "3"
#   metric_name         = "RequestCount"
#   namespace           = "AWS/ApplicationELB"
#   period              = "60"
#   statistic           = "Sum"
#   threshold           = 400
#   alarm_description   = "Number of request in ALB"
#   datapoints_to_alarm = 3
#   alarm_actions       = [var.sns_cloudwatch_alarms_arn]
#   ok_actions          = [var.sns_cloudwatch_alarms_arn]

#   dimensions = {
#     "LoadBalancer"     = var.alb_matching_arn_suffix
#   }
# }

###################
######TargetResponseTime
# resource "aws_cloudwatch_metric_alarm" "alb_matching_ResponseTime" {
#   alarm_name          = "${var.app_name}-${var.environment}-alb-matching-ResponseTime"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "3"
#   metric_name         = "TargetResponseTime"
#   namespace           = "AWS/ApplicationELB"
#   period              = "60"
#   statistic           = "Sum"
#   threshold           = 300
#   alarm_description   = "Target Response Time in ALB"
#   datapoints_to_alarm = 3
#   alarm_actions       = [var.sns_cloudwatch_alarms_arn]

#   dimensions = {
#     "LoadBalancer"     = var.alb_matching_arn_suffix
#   }
# }

resource "aws_cloudwatch_metric_alarm" "alb_backend_ResponseTime" {
  alarm_name          = "${var.app_name}-${var.environment}-alb-backend-ResponseTime"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = 300
  alarm_description   = "Target Response Time in ALB"
  datapoints_to_alarm = 3
  alarm_actions       = [var.sns_cloudwatch_alarms_arn]

  dimensions = {
    "LoadBalancer"     = var.alb_backend_arn_suffix
  }
}
resource "aws_cloudwatch_metric_alarm" "alb_odoo_ResponseTime" {
  alarm_name          = "${var.app_name}-${var.environment}-alb-odoo-ResponseTime"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = 300
  alarm_description   = "Target Response Time in ALB"
  datapoints_to_alarm = 3
  alarm_actions       = [var.sns_cloudwatch_alarms_arn]

  dimensions = {
    "LoadBalancer"     = var.alb_odoo_arn_suffix
  }
}
resource "aws_cloudwatch_metric_alarm" "alb_celery_ResponseTime" {
  alarm_name          = "${var.app_name}-${var.environment}-alb-celery-ResponseTime"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = 400
  alarm_description   = "Target Response Time in ALB"
  datapoints_to_alarm = 3
  alarm_actions       = [var.sns_cloudwatch_alarms_arn]

  dimensions = {
    "LoadBalancer"     = var.alb_celery_arn_suffix
  }
}

###################
#####HTTPCode_ELB_5XX_Count
resource "aws_cloudwatch_metric_alarm" "alb_celery_5XX_Count" {
  alarm_name          = "${var.app_name}-${var.environment}-alb-celery-5XX-Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = 3
  alarm_description   = "5XX Count in ALB"
  datapoints_to_alarm = 3
  alarm_actions       = [var.sns_cloudwatch_alarms_arn]

  dimensions = {
    "LoadBalancer"     = var.alb_celery_arn_suffix
  }
}
resource "aws_cloudwatch_metric_alarm" "alb_odoo_5XX_Count" {
  alarm_name          = "${var.app_name}-${var.environment}-alb-odoo-5XX-Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = 3
  alarm_description   = "5XX Count in ALB"
  datapoints_to_alarm = 3
  alarm_actions       = [var.sns_cloudwatch_alarms_arn]

  dimensions = {
    "LoadBalancer"     = var.alb_odoo_arn_suffix
  }
}
resource "aws_cloudwatch_metric_alarm" "alb_backend_5XX_Count" {
  alarm_name          = "${var.app_name}-${var.environment}-alb-backend-5XX-Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = 3
  alarm_description   = "5XX Count in ALB"
  datapoints_to_alarm = 3
  alarm_actions       = [var.sns_cloudwatch_alarms_arn]

  dimensions = {
    "LoadBalancer"     = var.alb_backend_arn_suffix
  }
}
# resource "aws_cloudwatch_metric_alarm" "alb_matching_5XX_Count" {
#   alarm_name          = "${var.app_name}-${var.environment}-alb-matching-5XX-Count"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "5"
#   metric_name         = "HTTPCode_ELB_5XX_Count"
#   namespace           = "AWS/ApplicationELB"
#   period              = "60"
#   statistic           = "Sum"
#   threshold           = 3
#   alarm_description   = "5XX Count in ALB"
#   datapoints_to_alarm = 3
#   alarm_actions       = [var.sns_cloudwatch_alarms_arn]

#   dimensions = {
#     "LoadBalancer"     = var.alb_matching_arn_suffix
#   }
# }