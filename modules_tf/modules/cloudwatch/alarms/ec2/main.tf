resource "aws_cloudwatch_metric_alarm" "ec2_tools_CPU" {

  alarm_name                = "${var.app_name}-${var.environment}-ec2-tools-CPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_cloudwatch_alarms_arn]
  ok_actions                = [var.sns_cloudwatch_alarms_arn]

  dimensions                = {
    "InstanceId"            = var.ec2_tools_id
  }

}