variable "environment" {
   description = "Set environment name"
}
variable "app_name" {
   description = "Set app name"
}
variable "region" {
   description = "Set region"
}
variable "codebuild_role_arn" {
   description = "Set arn role"
}
variable "vpc_id" {
   description = "Set arn role"
}
variable "codebuild_subnets" {
   description = "Set subnets "
}
variable "codebuild_security_group" {
   description = "Set security group "
}
variable "codebuild_image" {
   description = "Set image for codebuild"
}
variable "taskdef_file" {
   description = "Set taskdef file name"
}


###DB
variable "repo_db_url" {
   description = "Set url of repo"
}

####FRONTEND
variable "secret_frontend_arn" {
   description = "Set arn secret for envar"
}
variable "secret_frontend_name" {
   description = "Set name secret for envar"
}
variable "repo_frontend_url" {
   description = "Set url of repo"
}
variable "cloudfront_frontend_id" {
   description = "Set id of distro"
}


####BACKEND
variable "secret_backend_arn" {
   description = "Set arn secret for envar"
}
variable "repo_backend_url" {
   description = "Set url of repo"
}


####ODOO
variable "secret_odoo_arn" {
   description = "Set arn secret for envar"
}
variable "secret_odoo_name" {
   description = "Set name secret for envar"
}
variable "repo_odoo_url" {
   description = "Set url of repo"
}
variable "efs_odoo_id" {
   description = "Set efs id"
}


####MATCHING
variable "secret_matching_arn" {
   description = "Set arn secret for envar"
}
variable "repo_matching_url" {
   description = "Set url of repo"
}


