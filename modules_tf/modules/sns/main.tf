###########################################
# SNS Topics
###########################################

# ###Candidate_Profile
# resource "aws_sns_topic" "sns_candidate_profile" {
#   name              = "${var.app_name}-${var.environment}-${var.sns_candidate_profile}"
#   kms_master_key_id = "alias/aws/sns"
# }

# resource "aws_sns_topic_subscription" "sub_candidate_profile" {
#   topic_arn = aws_sns_topic.sns_candidate_profile.arn
#   protocol  = "https"
#   endpoint  = "https://${var.odoo_subdomain}.${var.main_domain}${var.endpoint_candidate_profile}"
# }

###Learning_Started
resource "aws_sns_topic" "sns_learning_started" {
  name              = "${var.app_name}-${var.environment}-${var.sns_learning_started}"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "sub_learning_started" {
  topic_arn = aws_sns_topic.sns_learning_started.arn
  protocol  = "https"
  endpoint  = "https://${var.backend_subdomain}.${var.main_domain}${var.endpoint_learning_started}"
}

###Skills_test
resource "aws_sns_topic" "sns_skills_test" {
  name              = "${var.app_name}-${var.environment}-${var.sns_skills_test}"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "sub_skills_test" {
  topic_arn = aws_sns_topic.sns_skills_test.arn
  protocol  = "https"
  endpoint  = "https://${var.backend_subdomain}.${var.main_domain}${var.endpoint_skills_test}"
}

resource "aws_sns_topic_subscription" "sub_skills_test2" {
  topic_arn = aws_sns_topic.sns_skills_test.arn
  protocol  = "https"
  endpoint  = "https://${var.backend_subdomain}.${var.main_domain}${var.endpoint_skills_test2}"
}

resource "aws_sns_topic_subscription" "sub_skills_test3" {
  topic_arn = aws_sns_topic.sns_skills_test.arn
  protocol  = "https"
  endpoint  = "https://${var.backend_subdomain}.${var.main_domain}${var.endpoint_skills_test3}"
}

resource "aws_sns_topic_subscription" "sub_skills_test4" {
  topic_arn = aws_sns_topic.sns_skills_test.arn
  protocol  = "https"
  endpoint  = "https://${var.odoo_subdomain}.${var.main_domain}${var.endpoint_skills_test4}"
}

resource "aws_sns_topic_subscription" "sub_skills_test5" {
  topic_arn = aws_sns_topic.sns_skills_test.arn
  protocol  = "https"
  endpoint  = "https://${var.backend_subdomain}.${var.main_domain}${var.endpoint_skills_test5}"
}