output "sqs_company_reports_url" {
  value       = aws_sqs_queue.sqs_company_reports.id
}

output "sqs_company_reports_arn" {
  value       = aws_sqs_queue.sqs_company_reports.arn
}

output "sqs_company_reports_name" {
  value       = aws_sqs_queue.sqs_company_reports.name
}