###########################################
# SNS Topic
###########################################
resource "aws_sns_topic" "sns_cloudwatch_alarms" {
  name              = "${var.app_name}-${var.environment}-sns-cloudwatch-alarms"
}

resource "aws_sns_topic_subscription" "sub_cloudwatch_alarms" {
  topic_arn = aws_sns_topic.sns_cloudwatch_alarms.arn
  protocol  = "email"
  endpoint  = "engineering@workera.ai"
}
