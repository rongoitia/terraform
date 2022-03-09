output "cloudfront_frontend_id" {
  value       = aws_cloudfront_distribution.frontend_distribution.id
}

output "cloudfront_frontend_endpoint" {
  value       = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "cloudfront_keygroup_name" {
  value       = aws_cloudfront_key_group.cf_keygroup.name
}

output "cloudfront_public_key_id" {
  value       = aws_cloudfront_public_key.cf_key.id
}

output "cloudfront_oai_iam_arn" {
  value       = aws_cloudfront_origin_access_identity.cloudfront_oai.iam_arn
}

output "cloudfront_oai_canonical_id" {
  value       = aws_cloudfront_origin_access_identity.cloudfront_oai.s3_canonical_user_id
}

output "cloudfront_download_endpoint" {
   value      = aws_cloudfront_distribution.download_distribution.domain_name
}