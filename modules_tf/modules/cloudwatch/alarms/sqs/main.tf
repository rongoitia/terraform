resource "aws_cloudwatch_metric_alarm" "sqs_company_reports_AgeMessage" {

  alarm_name                = "${var.app_name}-${var.environment}-sqs-company-reports-AgeOfMessage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "15"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "This metric monitors SQS approximate age of oldest message"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_cloudwatch_alarms_arn]
  ok_actions                = [var.sns_cloudwatch_alarms_arn]

  dimensions                = {
    "QueueName"             = var.sqs_company_reports_name
  }

}
