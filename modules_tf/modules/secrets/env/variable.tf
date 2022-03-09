variable "name" {
  description    = "Set name variable"
}


#####ENVARS VALUES
variable "environment" {
   description = "Set environment name"
}
variable "sns_topic_arn_candidate_profile_arn" {
   description = "Set arn sns"
}
variable "sns_topic_arn_learning_started_arn" {
   description = "Set arn sns"
}
variable "sns_topic_arn_skills_test_arn" {
   description = "Set arn sns"
}


variable "s3_sensei_resumes_name" {
  description = "Set s3 name"
}
variable "s3_workera_downloadable_files_name" {
  description = "Set s3 name"
}
variable "s3_reach_ai_media_name" {
  description = "Set s3 name"
}
variable "s3_workera_certificates_name" {
  description = "Set s3 name"
}
variable "s3_workera_certificates_regional_name" {
  description = "Set s3 regional name"
}

variable "frontend_url" {
   description = "Set a Subdomain"
}
variable "odoo_url" {
   description = "Set a Subdomain"
}
variable "backend_url" {
   description = "Set a Subdomain"
}
variable "matching_url" {
   description = "Set a Subdomain"
}

variable "sqs_company_reports" {
   description = "Set a sqs "
}
variable "s3_company_reports_name" {
   description = "Set a s3 bucket"
}

variable "s3_app_files_name" {
   description = "Set a s3 bucket"
}

variable "public_key_id_to_sign_url" {
   description = "Set public key id"
}

variable "private_key_to_sign_url" {
   description = "Set private key name"
}

variable "download_url" {
   description = "Set URL to download"
}