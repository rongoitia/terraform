output "sns_topic_arn_candidate_profile_arn" {
  value       = "empty"
}

output "sns_topic_arn_learning_started_arn" {
  value       = aws_sns_topic.sns_learning_started.arn
}

output "sns_topic_arn_skills_test_arn" {
  value       = aws_sns_topic.sns_skills_test.arn
}
