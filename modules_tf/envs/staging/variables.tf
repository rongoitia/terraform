########################################################################
# Main Environment Variables
# In this file, the type for variables used in the resource are declared
# If there is a new variable added, the variable and type shoud be
# added here.
#########################################################################

### Providers
variable "region" {
   type = string
}
# variable "profile" {
#    type = string
# }
variable app_name {
   type = string
}
variable environment {
   type = string
}
variable owner {
   type = number
}

### VPC
variable "enable_dns_hostnames" {
   type = bool
}
#variable "elastic_ip_id" {
#   type = string
#}
variable "az_a" {
   type = string
}
variable "az_b" {
   type = string
}
variable "az_c" {
   type = string
}
variable "cidr_block_a" {
   type = string
}
variable "cidr_block_b" {
   type = string
}
variable "cidr_block_c" {
   type = string
}
variable "cidr_block_d" {
   type = string
}
variable "cidr_block_e" {
   type = string
}
variable "cidr_block_f" {
   type = string
}
variable "cidr_block" {
   type = string
}

# Elastic IP
variable "vpc_true" {
   type = bool
}

### Route Tables
variable "rt_cidr_block" {
   type = string
}

# SNS Endpoint
variable "sns_endpoint" {
   type = string
}


### RDS
variable "allocated_storage" {
  type = number
}
variable "storage_type" {
  type = string
}
variable "snapshot_identifier" {
  type = string
}
variable "snapshot_identifies" {
  type = string
}
variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}

variable "family_parameter_group" {
  type = string
}
variable "instance_class" {
  type = string
}
variable "db_name" {
  type = string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type = string
}
variable "maintenance_window" {
  type = string
}
variable "skip_final_snapshot" {
  type = bool
}
variable "storage_encrypted" {
  type = bool
}
variable "multi_az" {
  type = bool
}

variable "max_allocated_storage" {
  type = number
}

variable "publicly_accessible" {
  type = bool
}
variable "backup_retention_period" {
  type = number
}
variable "backup_window" {
  type = string
}
# variable "availability_zone" {
#   type = string
# }

### Application Load Balancer

variable "idle_timeout" {
   type = number
}
variable "deregistration_delay" {
   type = number
}

variable "certificate" {
   type = string
}

### TargetGroups
variable "alb_tg_port_backend" {
   type = number
}
variable "alb_tg_protocol_backend" {
   type = string
}
variable "alb_tg_path_backend" {
   type = string
}
variable "alb_tg_code_backend" {
   type = string
}
variable "alb_tg_port_odoo" {
   type = number
}
variable "alb_tg_protocol_odoo" {
   type = string
}
variable "alb_tg_path_odoo" {
   type = string
}
variable "alb_tg_code_odoo" {
   type = string
}

variable "alb_tg_port_matching" {
   type = number
}
variable "alb_tg_protocol_matching" {
   type = string
}
variable "alb_tg_path_matching" {
   type = string
}
variable "alb_tg_code_matching" {
   type = string
}

variable "alb_tg_port_celery" {
   type = number
}
variable "alb_tg_protocol_celery" {
   type = string
}
variable "alb_tg_path_celery" {
   type = string
}
variable "alb_tg_code_celery" {
   type = string
}



### ECR
variable "scan_image" {
   type = bool
}


### ECS Clusters
variable "backend_cluster" {
   type = string
}
variable "odoo_cluster" {
   type = string
}
variable "matching_cluster" {
   type = string
}
variable "celery_cluster" {
   type = string
}


### ECS Service
variable "desired_task_backend" {
  type    = number
}
variable "container_port_backend" {
  type    = number
}
variable "desired_task_odoo" {
  type    = number
}
variable "container_port_odoo" {
  type    = number
}
variable "desired_task_matching" {
  type    = number
}
variable "container_port_matching" {
  type    = number
}
variable "desired_task_celery" {
  type    = number
}
variable "container_port_celery" {
  type    = number
}

### Autoscaling
variable "key_name" {
   type = string
}
variable "ecs_ami_id" {
   type = string
}
variable "backend_min" {
   type = number
}
variable "backend_max" {
   type = number
}
variable "backend_desired" {
   type = number
}
variable "backend_instance_type" {
   type = string
}
variable "odoo_min" {
   type = number
}
variable "odoo_max" {
   type = number
}
variable "odoo_desired" {
   type = number
}
variable "odoo_instance_type" {
   type = string
}
variable "matching_min" {
   type = number
}
variable "matching_max" {
   type = number
}
variable "matching_desired" {
   type = number
}
variable "matching_instance_type" {
   type = string
}
variable "celery_min" {
   type = number
}
variable "celery_max" {
   type = number
}
variable "celery_desired" {
   type = number
}
variable "celery_instance_type" {
   type = string
}

### SNS Topics
variable "sns_candidate_profile" {
   type = string
}
variable "endpoint_candidate_profile" {
   type = string
}
variable "sns_learning_started" {
   type = string
}
variable "endpoint_learning_started" {
   type = string
}
variable "sns_skills_test" {
   type = string
}
variable "endpoint_skills_test" {
   type = string
}
variable "endpoint_skills_test2" {
   type = string
}
variable "endpoint_skills_test3" {
   type = string
}
variable "endpoint_skills_test4" {
   type = string
}
variable "endpoint_skills_test5" {
   type = string
}

### Codebuild
variable "codebuild_image" {
  type = string
}

variable "repo_db_url" {
  type = string
}
variable "repo_frontend_url" {
  type = string
}
variable "repo_backend_url" {
  type = string
}
variable "repo_odoo_url" {
  type = string
}
variable "repo_matching_url" {
  type = string
}

### CodePipeline
variable "taskdef_file" {
  type = string
}
variable "repo_name_db" {
  type = string
}
variable "branch_db" {
  type = string
}
variable "repo_name_frontend" {
  type = string
}
variable "branch_frontend" {
  type = string
}
variable "repo_name_backend" {
  type = string
}
variable "branch_backend" {
  type = string
}
variable "repo_name_odoo" {
  type = string
}
variable "branch_odoo" {
  type = string
}
variable "repo_name_matching" {
  type = string
}
variable "branch_matching" {
  type = string
}


### Cloudfront
variable "arn_certificate_cloudfront" {
  type = string
}
variable "frontend_cnames" {
  type = list
}



### S3 Website
variable "name_company_website" {
  type = string
}
variable "acl_company_website" {
  type = string
}
variable "main_domain" {
  type = string
}
variable "frontend_subdomain" {
  type = string
}
variable "odoo_subdomain" {
  type = string
}
variable "backend_subdomain" {
  type = string
}
variable "matching_subdomain" {
  type = string
}
variable "name_company_reports" {
  type = string
}
variable "acl_company_reports" {
  type = string
}
variable "name_app_files" {
  type = string
}
variable "acl_app_files" {
  type = string
}


### S3 Buckets
variable "name_sensei_resumes" {
  type = string
}
variable "acl_sensei_resumes" {
  type = string
}

variable "name_company_downloadable_files" {
  type = string
}
variable "acl_company_downloadable_files" {
  type = string
}

variable "name_company_certificates" {
  type = string
}
variable "acl_company_certificates" {
  type = string
}

variable "name_reach_ai_media" {
  type = string
}
variable "acl_reach_ai_media" {
  type = string
}

variable "name_mlp_matching_results" {
  type = string
}
variable "acl_mlp_matching_results" {
  type = string
}

variable "name_company_public_sources" {
  type = string
}
variable "acl_company_public_sources" {
  type = string
}

variable "name_company_secret_files" {
  type = string
}
variable "acl_company_secret_files" {
  type = string
}

#### IAM Audit-Role
variable "audit_account_id" {
  type = string
}
variable "audit_external_id" {
  type = string
}
variable "vanta_key" {
  type = string
}

variable "rds_memory_min" {
  type = string
}

variable "download_subdomain" {
  type = string
}
# ### Backend - S3
# variable "bucket" {
#    type = string
# }
# variable "key" {
#    type = string
# }
