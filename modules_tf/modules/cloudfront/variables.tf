### ECS Cluster Variables
variable "environment" {
   description = "Set environment name"
}
variable "app_name" {
   description = "Set app name"
}
variable "arn_certificate_cloudfront" {
  description    = "Set arn for Certificate"
}
variable "s3_access_log_name" {
  description    = "Set access log s3 name"
}

variable "frontend_cnames" {
  description    = "Set list of alternative subdomains"
}

variable "frontend_subdomain" {
  description    = "Set frontend subdomain"
}

variable "main_domain" {
  description    = "Set domain"
}


variable "lambda_cloudfront_request_arn" {
  description    = "Set arn of lambda"
}

variable "lambda_cloudfront_web_redirect_arn" {
  description    = "Set arn of lambda"
}


variable "workera_frontend_website_regional_name" {
  description    = "Set bucket regional name"
}
variable "workera_frontend_website_id" {
  description    = "Set bucket id"
}

variable "reach_ai_media_regional_name" {
  description    = "Set bucket regional name"
}
variable "reach_ai_media_id" {
  description    = "Set bucket id"
}

variable "cloudfront_function_security_header" {
  description    = "Set cloudfront function securiry_header ARN"
}

variable "public_key" {
  description    = "Set public key for Cloudfront key"
}

variable "report_bucket_regional_name" {
  description    = "Set report bucket regional name"
}
variable "report_bucket_id" {
  description    = "Set report bucket id"
}

variable "download_subdomain" {
  description    = "Set Download frontend submain"
}
