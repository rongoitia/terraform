output "workera_frontend_website_name" {
  value       = aws_s3_bucket.workera_frontend_website.bucket
}
output "workera_frontend_website_arn" {
  value       = aws_s3_bucket.workera_frontend_website.arn
}
output "workera_frontend_website_regional_name" {
  value       = aws_s3_bucket.workera_frontend_website.bucket_regional_domain_name
}
output "workera_frontend_website_id" {
  value       = aws_s3_bucket.workera_frontend_website.id
}

