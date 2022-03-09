output "s3_access_log_name" {
  value       = aws_s3_bucket.s3_access_log.bucket
}
output "s3_access_log_arn" {
  value       = aws_s3_bucket.s3_access_log.arn
}
output "s3_access_log_id" {
  value       = aws_s3_bucket.s3_access_log.id
}
