output "s3_sensei_resumes_arn" {
  value       = aws_s3_bucket.sensei_resumes.arn
}
output "s3_sensei_resumes_name" {
  value       = aws_s3_bucket.sensei_resumes.bucket
}
output "s3_workera_downloadable_files_arn" {
  value       = aws_s3_bucket.workera_downloadable_files.arn
}
output "s3_workera_downloadable_files_name" {
  value       = aws_s3_bucket.workera_downloadable_files.bucket
}
output "s3_workera_certificates_arn" {
  value       = aws_s3_bucket.workera_certificates.arn
}
output "s3_workera_certificates_name" {
  value       = aws_s3_bucket.workera_certificates.bucket
}
output "s3_workera_certificates_regional_name" {
  value       = aws_s3_bucket.workera_certificates.bucket_regional_domain_name
}

output "s3_reach_ai_media_arn" {
  value       = aws_s3_bucket.reach_ai_media.arn
}
output "s3_reach_ai_media_name" {
  value       = aws_s3_bucket.reach_ai_media.bucket
}

output "s3_reach_ai_media_regional_name" {
  value       = aws_s3_bucket.reach_ai_media.bucket_regional_domain_name
}
output "s3_reach_ai_media_id" {
  value       = aws_s3_bucket.reach_ai_media.id
}



output "s3_mlp_matching_results_arn" {
  value       = aws_s3_bucket.mlp_matching_results.arn
}
output "s3_mlp_matching_results_name" {
  value       = aws_s3_bucket.mlp_matching_results.bucket
}

output "s3_workera_public_sources_arn" {
  value       = aws_s3_bucket.workera_public_sources.arn
}
output "s3_workera_public_sources_name" {
  value       = aws_s3_bucket.workera_public_sources.bucket
}

output "s3_company_reports_arn" {
  value       = aws_s3_bucket.company_reports.arn
}
output "s3_company_reports_name" {
  value       = aws_s3_bucket.company_reports.bucket
}

output "s3_company_reports_regional_name" {
  value       = aws_s3_bucket.company_reports.bucket_regional_domain_name
}

output "s3_company_reports_id" {
  value       = aws_s3_bucket.company_reports.id
}

output "s3_app_files_arn" {
  value       = aws_s3_bucket.company_reports.arn
}
output "s3_app_files_name" {
  value       = aws_s3_bucket.app_files.bucket
}