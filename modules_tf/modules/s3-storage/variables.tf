### ECS Cluster Variables
variable "environment" {
   description = "Set environment name"
}
variable "app_name" {
   description = "Set app name"
}
variable "s3_access_log_name" {
  description    = "Set s3 bucket"
}

variable "name_sensei_resumes" {
  description    = "Set bucket name"
}
variable "acl_sensei_resumes" {
  description    = "Set bucket privacy"
}

variable "name_workera_downloadable_files" {
  description    = "Set bucket name"
}
variable "acl_workera_downloadable_files" {
  description    = "Set bucket privacy"
}

variable "name_workera_certificates" {
  description    = "Set bucket name"
}
variable "acl_workera_certificates" {
  description    = "Set bucket privacy"
}

variable "name_reach_ai_media" {
  description    = "Set bucket name"
}
variable "acl_reach_ai_media" {
  description    = "Set bucket privacy"
}

variable "name_mlp_matching_results" {
  description    = "Set bucket name"
}
variable "acl_mlp_matching_results" {
  description    = "Set bucket privacy"
}

variable "name_workera_public_sources" {
  description    = "Set bucket name"
}
variable "acl_workera_public_sources" {
  description    = "Set bucket privacy"
}

variable "name_company_reports" {
  description    = "Set bucket name"
}
variable "acl_company_reports" {
  description    = "Set bucket privacy"
}

variable "name_app_files" {
  description    = "Set bucket name"
}
variable "acl_app_files" {
  description    = "Set bucket privacy"
}

variable "cloudfront_oai_canonical_id" {
  description    = "Set oai canonical id"
}

