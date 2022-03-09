#########################################################################
# These are the vales of all variables used
# Run terraform init, plan or apply using this env file.
#########################################################################

#ENVIROMENT
environment                 = "dev"

#URLS
main_domain                 = "deeplearningtest.org"
odoo_subdomain              = "backoffice-dev"
frontend_subdomain          = "dev"
backend_subdomain           = "app-dev"
matching_subdomain          = "matching-dev"
download_subdomain          = "download-dev"

#BRANCHES
branch_db                   = "dev"
branch_frontend             = "dev"
branch_backend              = "dev"
branch_odoo                 = "dev"
branch_matching             = "dev"

#SNS
endpoint_candidate_profile  = "/workera_connect/notification_handler/candidate_profile"
endpoint_learning_started   = "/workera_upskilling/notification_handler/learning_started"
endpoint_skills_test        = "/workera_analytics/notification_handler/section_completed"
endpoint_skills_test2       = "/workera_connect/candidate/certificates/handle_sns/section_completed"
endpoint_skills_test3       = "/workera_upskilling/notification_handler/section_completed"
endpoint_skills_test4       = "/workera_backoffice/workera_connect/notification_handler/skills_test"
endpoint_skills_test5       = "/workera_learning/notification_handler/section_completed"


########################
# Providers
########################

#REMPLACE de VALUE FOR THE REGION THAT YOU WILL DEPLOY
# Oregon     (us-west-1)
# Virgina    (us-east-1)
# California (us-west-1)
# Ohio       (us-east-2)
# Central    (ca-central-1)
# Frankfurt  (eu-central-1)
# Irerland   (eu-west-1)
# London     (eu-west-2)
region 					= "us-east-2"
#profile 				= "workera"
app_name 				= "workera"
owner                   = 057742345217

########################
# VPC
########################
cidr_block              = "172.16.0.0/16"
enable_dns_hostnames    = true

#REMPLACE de VALUE FOR THE REGION THAT YOU WILL DEPLOY
# Oregon     (us-west-1)
# Virgina    (us-east-1)
# California (us-west-1)
# Ohio       (us-east-2)
# Central    (ca-central-1)
# Frankfurt  (eu-central-1)
# Irerland   (eu-west-1)
# London     (eu-west-2)
az_a = "us-east-2a"
az_b = "us-east-2b"
az_c = "us-east-2c"
#sns_endpoint = "com.amazonaws.us-east-2.sns"


#######################
# Public subnets
#######################
cidr_block_a = "172.16.1.0/24"
cidr_block_b = "172.16.2.0/24"
cidr_block_c = "172.16.3.0/24"

########################
# Private subnets
########################
cidr_block_d = "172.16.4.0/24"
cidr_block_e = "172.16.5.0/24"
cidr_block_f = "172.16.6.0/24"

########################
# Elastic IP
########################
# Set the Elastic IP Allocation ID
#elastic_ip_id       = "eipalloc-xxx"
vpc_true        = true

########################
# Route Table
########################
rt_cidr_block   = "0.0.0.0/0"

#######################
# RDS
#######################
allocated_storage       = 100
storage_type            = "gp2"
engine                  = "postgres"
engine_version          = "10.17"
#db_parameter_group_name = "db-parameter-group-workera"
family_parameter_group  = "postgres10"
instance_class          = "db.t3.medium"
# Set a DB Name when running terraform
db_name                 = "database_test"
# Set a DB Username when running terraform
db_username             = "admin_workera"
# Set a DB Password when running terraform
db_password             = "MfevW4bNzVV2yCMv"
publicly_accessible     = false
max_allocated_storage   = 200
##############Set a value "false" when we are live
skip_final_snapshot     = true
maintenance_window      = "Sat:03:00-Sat:04:00"
storage_encrypted       = true
multi_az                = true
snapshot_identifies     = ""
snapshot_identifier     = ""
backup_retention_period = 30
backup_window           = "05:00-05:30"
#availability_zone       = "us-east-2c, us-east-2b, us-east-1a"

########################
# Application LB
########################
idle_timeout                    = 600
deregistration_delay            = 30
certificate				        = "arn:aws:acm:us-east-2:057742345217:certificate/d98beca9-e1c7-4cf4-886e-3ef70656a002"

### TargetGroups
alb_tg_port_backend             = 80
alb_tg_protocol_backend         = "HTTP"
alb_tg_path_backend             = "/ht-mlp-backend/"
alb_tg_code_backend             = "200-499"

alb_tg_port_odoo                = 80
alb_tg_protocol_odoo            = "HTTP"
alb_tg_path_odoo                = "/web/login"
alb_tg_code_odoo                = "200-499"

alb_tg_port_matching            = 80
alb_tg_protocol_matching        = "HTTP"
alb_tg_path_matching            = "/health-check-endpoint/"
alb_tg_code_matching            = "200-499"

alb_tg_port_celery              = 80
alb_tg_protocol_celery          = "HTTP"
alb_tg_path_celery              = "/"
alb_tg_code_celery              = "200-499"

########################
# ECR
########################
scan_image                      = true

########################
# ECS CLUSTER
########################
backend_cluster             = "backend"
odoo_cluster                = "odoo"
matching_cluster            = "matching"
celery_cluster              = "celery"

########################
# ECS SERVICE
########################
desired_task_backend             = 1
container_port_backend           = 8000

desired_task_odoo                = 1
container_port_odoo              = 8069

desired_task_matching            = 1
container_port_matching          = 80

desired_task_celery              = 1
container_port_celery            = 80

########################
# Autoscaling
########################
key_name                = "dev"

#REMPLACE de VALUE AMI ID FOR THE REGION THAT YOU WILL DEPLOY
# Oregon     (us-west-1)    = ami-00780848600d687b6
# Virgina    (us-east-1)    = ami-0be13a99cd970f6a9
# California (us-west-1)    = ami-08c874a4d6382c4d9
# Ohio       (us-east-2)    = ami-0ecb1ece84d43215d
# Central    (ca-central-1) = ami-0f1c5116668d961c3
# Frankfurt  (eu-central-1) = ami-06aee3d58e37adccc
# Irerland   (eu-west-1)    = ami-0c62045417a6d2199
# London     (eu-west-2)    = ami-0af3e2dadaea9b470
ecs_ami_id              = "ami-01a4986c9e49a5c6a"

backend_min             = 1
backend_max             = 10
backend_desired         = 1
backend_instance_type   = "t3.medium"

odoo_min                = 1
odoo_max                = 10
odoo_desired            = 1
odoo_instance_type      = "t3.medium"

matching_min            = 1
matching_max            = 10
matching_desired        = 1
matching_instance_type  = "t3.small"

celery_min            = 1
celery_max            = 10
celery_desired        = 1
celery_instance_type  = "t3.small"

########################
# SNS Topics
########################
sns_candidate_profile       = "candidate-profile"
sns_learning_started        = "learning-started"
sns_skills_test             = "skills-test"

########################
# Codebuild
########################
codebuild_image             = "aws/codebuild/amazonlinux2-x86_64-standard:3.0-21.10.15"

repo_db_url                 = "https://github.com/deeplearning-ai/workera-db.git"
repo_frontend_url           = "https://github.com/deeplearning-ai/workera-frontend.git"
repo_backend_url            = "https://github.com/deeplearning-ai/machine-learning-platform.git"
repo_odoo_url               = "https://github.com/deeplearning-ai/mlp-odoo.git"
repo_matching_url           = "https://github.com/deeplearning-ai/matching.git"


########################
# CodePipeline
########################
taskdef_file                 = "devtaskdef.json"

repo_name_db                 = "deeplearning-ai/workera-db"

repo_name_frontend           = "deeplearning-ai/workera-frontend"

repo_name_backend            = "deeplearning-ai/machine-learning-platform"

repo_name_odoo               = "deeplearning-ai/mlp-odoo"

repo_name_matching           = "deeplearning-ai/matching"


########################
# S3 WEBSITE
########################
name_workera_website             = "workera-frontend-website"
acl_workera_website              = "public-read"


########################
# Cloudfront
########################
arn_certificate_cloudfront       =  "arn:aws:acm:us-east-1:057742345217:certificate/0102eadc-5f05-4690-b98e-8b0f983943ac"
frontend_cnames                  = ["*.deeplearningtest.org"]


########################
# S3 Buckets
########################
name_sensei_resumes             = "sensei-resumes"
acl_sensei_resumes              = "private"

name_workera_downloadable_files = "workera-downloadable-files"
acl_workera_downloadable_files  = "private"

name_workera_certificates       = "workera-certificates"
acl_workera_certificates        = "private"

name_reach_ai_media             = "reach-ai-media"
acl_reach_ai_media              = "public-read-write"

name_mlp_matching_results       = "mlp-matching-results"
acl_mlp_matching_results        = "private"

name_workera_public_sources     = "workera-public-sources"
acl_workera_public_sources      = "public-read-write"

name_workera_secret_files       = "workera-secret-files"
acl_workera_secret_files        = "private"

name_company_reports            = "workera-company-reports"
acl_company_reports             = "private"

name_app_files                  = "workera-app-files"
acl_app_files                   = "private"


########################
# IAM Audit Role
########################
audit_account_id                = "XXXXXX"
audit_external_id               = "XXXXXXX"
vanta_key                       = "XXXXXXX"
