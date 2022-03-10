

# -- Modules ----------------------------------------------------------------
module "vpc" {
  source                      	= "../../modules/vpc"
  region                        = var.region
  cidr_block                  	= var.cidr_block
  enable_dns_hostnames          = var.enable_dns_hostnames
  az_a                       		= var.az_a
  az_b                       		= var.az_b
  az_c                       		= var.az_c

  # Public subnets
  cidr_block_a                  = var.cidr_block_a
  cidr_block_b                  = var.cidr_block_b
  cidr_block_c                  = var.cidr_block_c

  # Private Subnets
  cidr_block_d 				          = var.cidr_block_d
  cidr_block_e 				          = var.cidr_block_e
  cidr_block_f 				          = var.cidr_block_f

  # Elastic IP
  #elastic_ip_id                = var.elastic_ip_id
  vpc_true                      = var.vpc_true

  # route tables
  rt_cidr_block 			          = var.rt_cidr_block

  # SNS endpoint
  #sns_endpoint                  = var.sns_endpoint

  app_name      			          = var.app_name
  environment                   = var.environment
}

module "vpc-flow-log" {
  source              = "../../modules/vpc-flow-log"
  vpc_id              = module.vpc.vpc_id
  app_name      			= var.app_name
  environment         = var.environment
}

module "security-groups" {
  source 		         = "../../modules/security-groups"
  vpc_id             = module.vpc.vpc_id

  cidr_block         = var.cidr_block
  environment        = var.environment
  app_name           = var.app_name
}

module "rds" {
  source                    = "../../modules/rds-replica"
  identifier                = "${var.app_name}-${var.environment}-rds"
  #allocated_storage         = var.allocated_storage
  storage_type              = var.storage_type
  #engine                    = var.engine
  engine_version            = var.engine_version
  family_parameter_group	  = var.family_parameter_group
  instance_class            = var.instance_class
  #db_name                   = var.db_name
  db_username               = var.db_username
  #db_password               = var.db_password
  publicly_accessible       = var.publicly_accessible
  max_allocated_storage     = var.max_allocated_storage
  maintenance_window        = var.maintenance_window
  backup_retention_period   = var.backup_retention_period
  skip_final_snapshot       = var.skip_final_snapshot
  snapshot_identifies       = var.snapshot_identifies
  snapshot_identifier       = var.snapshot_identifier
  backup_window             = var.backup_window
  #availability_zone         = var.availability_zone
  storage_encrypted         = var.storage_encrypted
  multi_az                  = var.multi_az
  environment               = var.environment
  app_name                  = var.app_name
  db_subnet_group_list      = [module.vpc.private-a-id,module.vpc.private-b-id,module.vpc.private-c-id]
  security_group_id         = [module.security-groups.sg_db_id]
}

module "application-load-balancer" {
  source 			                  = "../../modules/application-load-balancer"
  subnets 			                = [module.vpc.public-a-id,module.vpc.public-b-id,module.vpc.public-c-id]
  alb_security_group            = [module.vpc.default_sg_id]
  idle_timeout                  = var.idle_timeout
  environment                   = var.environment
  app_name                      = var.app_name
  certificate	      	          = var.certificate
  s3_access_log_name            = module.s3.s3_access_log_name
  frontend_subdomain            = var.frontend_subdomain
  main_domain                   = var.main_domain

  # Target Groups
  vpc_id                		    = module.vpc.vpc_id
  deregistration_delay          = var.deregistration_delay


  alb_tg_port_odoo      		    = var.alb_tg_port_odoo
  alb_tg_protocol_odoo  		    = var.alb_tg_protocol_odoo
  alb_tg_path_odoo   		        = var.alb_tg_path_odoo
  alb_tg_code_odoo   		        = var.alb_tg_code_odoo

  alb_tg_port_backend      		  = var.alb_tg_port_backend
  alb_tg_protocol_backend  		  = var.alb_tg_protocol_backend
  alb_tg_path_backend   		    = var.alb_tg_path_backend
  alb_tg_code_backend   		    = var.alb_tg_code_backend

  # alb_tg_port_matching      		= var.alb_tg_port_matching
  # alb_tg_protocol_matching  		= var.alb_tg_protocol_matching
  # alb_tg_path_matching   		    = var.alb_tg_path_matching
  # alb_tg_code_matching   		    = var.alb_tg_code_matching

  alb_tg_port_celery      		  = var.alb_tg_port_celery
  alb_tg_protocol_celery  		  = var.alb_tg_protocol_celery
  alb_tg_path_celery   		      = var.alb_tg_path_celery
  alb_tg_code_celery   		      = var.alb_tg_code_celery

}

 module "autoscaling" {
  source                      = "../../modules/autoscaling"
  security_group_id           = module.security-groups.sg_ecs_id
  security_group_id_backend   = module.security-groups.sg_ecs_id_backend
  security_group_id_odoo      = module.security-groups.sg_ecs_id_odoo
  # security_group_id_matching  = module.security-groups.sg_ecs_id_matching
  security_group_id_celery    = module.security-groups.sg_ecs_id_celery
  ecs_instance_profile_name   = module.ec2-role.ecs_instance_profile_name
  vanta_key                   = var.vanta_key

  ecs_subnet_group_list       = [module.vpc.private-a-id,module.vpc.private-b-id,module.vpc.private-c-id]
  key_name                    = var.key_name
  ecs_ami_id                  = var.ecs_ami_id

  backend_max                 = var.backend_max
  backend_min                 = var.backend_min
  backend_desired             = var.backend_desired
  backend_instance_type       = var.backend_instance_type

  odoo_max                    = var.odoo_max
  odoo_min                    = var.odoo_min
  odoo_desired                = var.odoo_desired
  odoo_instance_type          = var.odoo_instance_type

  # matching_max                = var.matching_max
  # matching_min                = var.matching_min
  # matching_desired            = var.matching_desired
  # matching_instance_type      = var.matching_instance_type

  celery_max                  = var.celery_max
  celery_min                  = var.celery_min
  celery_desired              = var.celery_desired
  celery_instance_type        = var.celery_instance_type

  environment                 = var.environment
  app_name                    = var.app_name
}

module "ecr" {
  source                        = "../../modules/ecr"
  environment                   = var.environment
  app_name                      = var.app_name
  scan_image				            = var.scan_image
}

module "ecs-cluster" {
  source          = "../../modules/ecs-cluster"
  backend         = "${var.app_name}-${var.environment}-${var.backend_cluster}"
  odoo            = "${var.app_name}-${var.environment}-${var.odoo_cluster}"
  # matching        = "${var.app_name}-${var.environment}-${var.matching_cluster}"
  celery          = "${var.app_name}-${var.environment}-${var.celery_cluster}"
}

module "ecs-task-definition" {
  source                = "../../modules/ecs-task-definition"
  name                  = "${var.app_name}-${var.environment}"
}

module "ecs-service" {
  source                          = "../../modules/ecs-service"
  environment                     = var.environment
  app_name                        = var.app_name
  name                            = "${var.app_name}-${var.environment}"
  service_role_name               = module.ecs-role.service_role_name

  ecs_cluster_name_backend           = module.ecs-cluster.ecs_cluster_name_backend
  task_definition_arn_backend        = module.ecs-task-definition.task_definition_arn_backend
  target_group_arn_backend_1         = module.application-load-balancer.tg_backend_1_arn
  desired_task_backend               = var.desired_task_backend
  container_port_backend             = var.container_port_backend

  ecs_cluster_name_odoo           = module.ecs-cluster.ecs_cluster_name_odoo
  task_definition_arn_odoo        = module.ecs-task-definition.task_definition_arn_odoo
  target_group_arn_odoo_1         = module.application-load-balancer.tg_odoo_1_arn
  desired_task_odoo               = var.desired_task_odoo
  container_port_odoo             = var.container_port_odoo

  # ecs_cluster_name_matching           = module.ecs-cluster.ecs_cluster_name_matching
  # task_definition_arn_matching        = module.ecs-task-definition.task_definition_arn_matching
  # target_group_arn_matching_1         = module.application-load-balancer.tg_matching_1_arn
  # desired_task_matching               = var.desired_task_matching
  # container_port_matching             = var.container_port_matching

  ecs_cluster_name_celery           = module.ecs-cluster.ecs_cluster_name_celery
  task_definition_arn_celery        = module.ecs-task-definition.task_definition_arn_celery
  target_group_arn_celery_1         = module.application-load-balancer.tg_celery_1_arn
  desired_task_celery               = var.desired_task_celery
  container_port_celery             = var.container_port_celery

}

module "codedeploy" {
  source                          = "../../modules/codedeploy"
  environment                     = var.environment
  app_name                        = var.app_name
  name                            = "${var.app_name}-${var.environment}"
  codedeploy_role_arn             = module.codedeploy-role.codedeploy_role_arn

  ecs_cluster_name_backend        = module.ecs-cluster.ecs_cluster_name_backend
  ecs_service_backend             = module.ecs-service.ecs_service_backend
  listener_arn_backend            = module.application-load-balancer.listener_backend_https_arn
  target_group_name_backend_1     = module.application-load-balancer.tg_backend_1_name
  target_group_name_backend_2     = module.application-load-balancer.tg_backend_2_name

  ecs_cluster_name_odoo           = module.ecs-cluster.ecs_cluster_name_odoo
  ecs_service_odoo                = module.ecs-service.ecs_service_odoo
  listener_arn_odoo               = module.application-load-balancer.listener_odoo_https_arn
  target_group_name_odoo_1        = module.application-load-balancer.tg_odoo_1_name
  target_group_name_odoo_2        = module.application-load-balancer.tg_odoo_2_name

  # ecs_cluster_name_matching       = module.ecs-cluster.ecs_cluster_name_matching
  # ecs_service_matching            = module.ecs-service.ecs_service_matching
  # listener_arn_matching           = module.application-load-balancer.listener_matching_https_arn
  # target_group_name_matching_1    = module.application-load-balancer.tg_matching_1_name
  # target_group_name_matching_2    = module.application-load-balancer.tg_matching_2_name

  ecs_cluster_name_celery       = module.ecs-cluster.ecs_cluster_name_celery
  ecs_service_celery            = module.ecs-service.ecs_service_celery
  listener_arn_celery           = module.application-load-balancer.listener_celery_https_arn
  target_group_name_celery_1    = module.application-load-balancer.tg_celery_1_name
  target_group_name_celery_2    = module.application-load-balancer.tg_celery_2_name
}

# module "codebuild" {
#   source                          = "../../modules/codebuild"
#   environment                     = var.environment
#   app_name                        = var.app_name
#   codebuild_role_arn              = module.codebuild-role.codebuild_role_arn
#   vpc_id                		      = module.vpc.vpc_id
#   codebuild_subnets               = [module.vpc.private-a-id,module.vpc.private-b-id,module.vpc.private-c-id]
#   codebuild_security_group        = [module.vpc.default_sg_id]
#   codebuild_image                 = var.codebuild_image
#   region                          = var.region
#   taskdef_file                    = var.taskdef_file

#   repo_db_url                     = var.repo_db_url

#   repo_frontend_url               = var.repo_frontend_url
#   secret_frontend_arn             = module.secrets_frontend.secrets_frontend_arn
#   secret_frontend_name            = module.secrets_frontend.secrets_frontend_name
#   cloudfront_frontend_id          = module.cloudfront.cloudfront_frontend_id

#   repo_backend_url                = var.repo_backend_url
#   secret_backend_arn              = module.secrets.secrets_backend_arn

#   repo_odoo_url                   = var.repo_odoo_url
#   secret_odoo_arn                 = module.secrets_odoo.secrets_odoo_arn
#   secret_odoo_name                = module.secrets_odoo.secrets_odoo_name
#   efs_odoo_id                     = module.efs.efs_odoo_id

#   repo_matching_url               = var.repo_matching_url
#   secret_matching_arn             = module.secrets_matching.secrets_matching_arn
# }

module "codebuild" {
  source                          = "../../modules/codebuild/codebuild-envs"
  environment                     = var.environment
  app_name                        = var.app_name
  codebuild_role_arn              = module.codebuild-role.codebuild_role_arn
  vpc_id                		      = module.vpc.vpc_id
  codebuild_subnets               = [module.vpc.private-a-id,module.vpc.private-b-id,module.vpc.private-c-id]
  codebuild_security_group        = [module.vpc.default_sg_id]
  codebuild_image                 = var.codebuild_image
  region                          = var.region
  taskdef_file                    = var.taskdef_file
  repo_db_url                     = var.repo_db_url
  secret_env_arn                  = module.secrets_env.secrets_env_arn
  secret_env_name                 = module.secrets_env.secrets_env_name

  secret_db_name                  = module.secrets_db.secrets_db_name

  repo_frontend_url               = var.repo_frontend_url
  secret_frontend_arn             = module.secrets_frontend.secrets_frontend_arn
  secret_frontend_name            = module.secrets_frontend.secrets_frontend_name
  cloudfront_frontend_id          = module.cloudfront.cloudfront_frontend_id

  repo_backend_url                = var.repo_backend_url
  secret_backend_arn              = module.secrets.secrets_backend_arn
  secret_backend_name             = module.secrets.secrets_backend_name

  repo_odoo_url                   = var.repo_odoo_url
  secret_odoo_arn                 = module.secrets_odoo.secrets_odoo_arn
  secret_odoo_name                = module.secrets_odoo.secrets_odoo_name
  efs_odoo_id                     = module.efs.efs_odoo_id

  # repo_matching_url               = var.repo_matching_url
  # secret_matching_arn             = module.secrets_matching.secrets_matching_arn
}

module "codepipeline" {
  source                          = "../../modules/codepipeline"
  environment                     = var.environment
  app_name                        = var.app_name
  codepipeline_role_arn           = module.codepipeline-role.codepipeline_role_arn
  taskdef_file                    = var.taskdef_file
  codestar_arn                    = module.codestar.codestar_arn

  branch_db                       = var.branch_db
  repo_name_db                    = var.repo_name_db

  branch_frontend                 = var.branch_frontend
  repo_name_frontend              = var.repo_name_frontend

  branch_backend                  = var.branch_backend
  repo_name_backend               = var.repo_name_backend

  branch_odoo                     = var.branch_odoo
  repo_name_odoo                  = var.repo_name_odoo

  # branch_matching                 = var.branch_matching
  # repo_name_matching              = var.repo_name_matching

}

module "codestar" {
  source                          = "../../modules/codestar"
  environment                     = var.environment
  app_name                        = var.app_name
}

# module "audit-role" {
#   source                          = "../../modules/iam/audit-role"
#   environment                     = var.environment
#   app_name                        = var.app_name
#   audit_account_id                = var.audit_account_id
#   audit_external_id               = var.audit_external_id
# }

# module "iam-user" {
#   source                          = "../../modules/iam/user"
#   environment                     = var.environment
#   app_name                        = var.app_name
# }

# module "iam-group" {
#   source                          = "../../modules/iam/group"
#   environment                     = var.environment
#   app_name                        = var.app_name
# }

module "sns" {
  source 		                  = "../../modules/sns"
  main_domain                 = var.main_domain
  odoo_subdomain              = var.odoo_subdomain
  backend_subdomain           = var.backend_subdomain
  frontend_subdomain          = var.frontend_subdomain
  # matching_subdomain          = var.main_domain

  sns_candidate_profile       = var.sns_candidate_profile
  endpoint_candidate_profile  = var.endpoint_candidate_profile

  sns_learning_started        = var.sns_learning_started
  endpoint_learning_started   = var.endpoint_learning_started

  sns_skills_test             = var.sns_skills_test
  endpoint_skills_test        = var.endpoint_skills_test
  endpoint_skills_test2       = var.endpoint_skills_test2
  endpoint_skills_test3       = var.endpoint_skills_test3
  endpoint_skills_test4       = var.endpoint_skills_test4
  endpoint_skills_test5       = var.endpoint_skills_test5

  environment                 = var.environment
  app_name                    = var.app_name
}

module "efs" {
  source 		           = "../../modules/efs-disk"
  subnet_id_a          = module.vpc.private-a-id
  subnet_id_b          = module.vpc.private-b-id
  subnet_id_c          = module.vpc.private-c-id

  environment                 = var.environment
  app_name                    = var.app_name
}

module "s3-website" {
  source 		                          = "../../modules/s3-website"
  environment                         = var.environment
  app_name                            = var.app_name

  name_company_frontend_website       = var.name_company_website
  acl_company_frontend_website        = var.acl_company_website
}


module "lambda-role" {
  source 		                    = "../../modules/lambda-role"
  name                          = "${var.app_name}-${var.environment}"
}

module "lambda-edge" {
  source 		                    = "../../modules/lambda-edge"
  name                          = "${var.app_name}-${var.environment}"
  lambda_role_arn               = module.lambda-role.lambda_role_arn
  odoo_subdomain                = var.odoo_subdomain
  main_domain                   = var.main_domain
  providers = {
    aws                         = aws.virginia
  }
}
module "pem-key" {
  source                        = "../../modules/key" 
}
module "cloudfront-function" {
  source                        = "../../modules/cloudfront-function"
  environment                   = var.environment
  app_name                      = var.app_name
}

module "cloudfront" {
  source 		                                  = "../../modules/cloudfront"
  environment                                 = var.environment
  app_name                                    = var.app_name
  arn_certificate_cloudfront                  = var.arn_certificate_cloudfront
  s3_access_log_name                          = module.s3.s3_access_log_name
  frontend_cnames                             = var.frontend_cnames
  frontend_subdomain                          = var.frontend_subdomain
  main_domain                                 = var.main_domain
  lambda_cloudfront_request_arn               = module.lambda-edge.lambda_cloudfront_request_arn
  lambda_cloudfront_web_redirect_arn          = module.lambda-edge.lambda_cloudfront_web_redirect_arn
  download_subdomain                          = var.download_subdomain

  company_frontend_website_regional_name      = module.s3-website.company_frontend_website_regional_name
  company_frontend_website_id                 = module.s3-website.company_frontend_website_id


  reach_ai_media_regional_name                = module.s3-storage.s3_reach_ai_media_regional_name
  reach_ai_media_id                           = module.s3-storage.s3_reach_ai_media_id

  cloudfront_function_security_header         = module.cloudfront-function.cloudfront_function_security_header

  report_bucket_regional_name                 = module.s3-storage.s3_company_reports_regional_name
  report_bucket_id                            = module.s3-storage.s3_company_reports_id
  public_key                                  = module.pem-key.public_key

}

module "report-bucket-policy" {
  source                = "../../modules/s3_reports_policy"
  bucket_arn            = module.s3-storage.s3_company_reports_arn
  bucket_id             = module.s3-storage.s3_company_reports_id
  iam_arn               = module.cloudfront.cloudfront_oai_iam_arn 
}

module "ssm-parameter" {
  source                = "../../modules/ssm-parameter"
  environment           = var.environment
  private_key           = module.pem-key.private_key
}

module "secrets" {
  source 		           = "../../modules/secrets/backend"
  name                 = "${var.app_name}-${var.environment}"
}

module "secrets_frontend" {
  source 		           = "../../modules/secrets/frontend"
  name                 = "${var.app_name}-${var.environment}"
}

module "secrets_odoo" {
  source 		           = "../../modules/secrets/odoo"
  name                 = "${var.app_name}-${var.environment}"
}

module "secrets_matching" {
  source 		           = "../../modules/secrets/matching"
  name                 = "${var.app_name}-${var.environment}"
}

module "secrets_db" {
  source 		           = "../../modules/secrets/db"
  name                 = "${var.app_name}-${var.environment}"
}

module "secrets_env" {
  source 		                            = "../../modules/secrets/env"
  name                                  = "${var.app_name}-${var.environment}"

  environment                           = var.environment

  sns_topic_arn_candidate_profile_arn   = module.sns.sns_topic_arn_candidate_profile_arn
  sns_topic_arn_learning_started_arn    = module.sns.sns_topic_arn_learning_started_arn
  sns_topic_arn_skills_test_arn         = module.sns.sns_topic_arn_skills_test_arn
  s3_sensei_resumes_name                = module.s3-storage.s3_sensei_resumes_name
  s3_company_downloadable_files_name    = module.s3-storage.s3_company_downloadable_files_name
  s3_reach_ai_media_name                = module.s3-storage.s3_reach_ai_media_name
  s3_company_certificates_name          = module.s3-storage.s3_company_certificates_name
  s3_company_reports_name               = module.s3-storage.s3_company_reports_name
  sqs_company_reports                   = module.sqs.sqs_company_reports_url
  s3_app_files_name                     = module.s3-storage.s3_app_files_name
  s3_company_certificates_regional_name = module.s3-storage.s3_company_certificates_regional_name

  frontend_url                          = "${var.frontend_subdomain}.${var.main_domain}"
  odoo_url                              = "${var.odoo_subdomain}.${var.main_domain}"
  backend_url                           = "${var.backend_subdomain}.${var.main_domain}"
  matching_url                          = "${var.matching_subdomain}.${var.main_domain}"
  public_key_id_to_sign_url             = module.cloudfront.cloudfront_public_key_id
	private_key_to_sign_url               = module.ssm-parameter.secret_key_name
  download_url                          = "${var.download_subdomain}.${var.main_domain}"
}

module "ec2-role" {
  source 		                    = "../../modules/ec2-role"
  environment                   = var.environment
  app_name                      = var.app_name
}

module "ecs-role" {
  source 		                    = "../../modules/ecs-role"
  name                          = "${var.app_name}-${var.environment}"
}

module "codedeploy-role" {
  source 		                    = "../../modules/codedeploy-role"
  name                          = "${var.app_name}-${var.environment}"
}

module "codepipeline-role" {
  source 		                    = "../../modules/codepipeline-role"
  name                          = "${var.app_name}-${var.environment}"
}

module "codebuild-role" {
  source 		                    = "../../modules/codebuild-role"
  name                          = "${var.app_name}-${var.environment}"
}

module "codestar-role" {
  source 		                    = "../../modules/codestar-role"
  name                          = "${var.app_name}-${var.environment}"
}

module "s3" {
  source 		                    = "../../modules/s3"
  environment                   = var.environment
  app_name                      = var.app_name

  name_company_secret_files     = var.name_company_secret_files
  acl_company_secret_files      = var.acl_company_secret_files
}

module "s3-storage" {
  source 		                    = "../../modules/s3-storage"
  environment                   = var.environment
  app_name                      = var.app_name
  s3_access_log_name            = module.s3.s3_access_log_name

  name_sensei_resumes           = var.name_sensei_resumes
  acl_sensei_resumes            = var.acl_sensei_resumes

  name_company_downloadable_files     = var.name_company_downloadable_files
  acl_company_downloadable_files      = var.acl_company_downloadable_files

  name_company_certificates     = var.name_company_certificates
  acl_company_certificates      = var.acl_company_certificates

  name_reach_ai_media           = var.name_reach_ai_media
  acl_reach_ai_media            = var.acl_reach_ai_media

  name_mlp_matching_results     = var.name_mlp_matching_results
  acl_mlp_matching_results      = var.acl_mlp_matching_results

  name_company_public_sources   = var.name_company_public_sources
  acl_company_public_sources    = var.acl_company_public_sources

  name_company_reports          = var.name_company_reports
  acl_company_reports           = var.acl_company_reports

  name_app_files                = var.name_app_files
  acl_app_files                 = var.acl_app_files

  cloudfront_oai_canonical_id   = module.cloudfront.cloudfront_oai_canonical_id

}

module "route53" {
  source 		                    = "../../modules/route53/company.ai"
  environment                   = var.environment
  app_name                      = var.app_name

  frontend_url                  = "${var.frontend_subdomain}.${var.main_domain}"
  frontend_endpoint             = module.cloudfront.cloudfront_frontend_endpoint

  odoo_url                      = "${var.odoo_subdomain}.${var.main_domain}"
  odoo_endpoint                 = module.application-load-balancer.alb_odoo_domain

  backend_url                   = "${var.backend_subdomain}.${var.main_domain}"
  backend_endpoint              = module.application-load-balancer.alb_backend_domain

  # matching_url                  = "${var.matching_subdomain}.${var.main_domain}"
  # matching_endpoint             = module.application-load-balancer.alb_matching_domain

  download_url                  = "${var.download_subdomain}.${var.main_domain}"
  download_endpoint             = module.cloudfront.cloudfront_download_endpoint

  depends_on = [
    module.application-load-balancer
  ]

}

module "sqs" {
  source 		                    = "../../modules/sqs"
  environment                   = var.environment
  app_name                      = var.app_name
}

module "cloudwatch-sns-alarms" {
  source 		                    = "../../modules/cloudwatch/sns-alarms"
  environment                   = var.environment
  app_name                      = var.app_name
}

module "cloudwatch-logs-groups" {
  source 		                    = "../../modules/cloudwatch/logs"
  environment                   = var.environment
  app_name                      = var.app_name
}

module "cloudwatch-alarms-rds" {
  source 		                    = "../../modules/cloudwatch/alarms/rds"
  environment                   = var.environment
  app_name                      = var.app_name
  rds_id                        = module.rds.rds_id
  rds_memory_min                = var.rds_memory_min
  sns_cloudwatch_alarms_arn      = module.cloudwatch-sns-alarms.sns_cloudwatch_alarms_arn
}

module "cloudwatch-alarms-sqs" {
  source 		                    = "../../modules/cloudwatch/alarms/sqs"
  environment                   = var.environment
  app_name                      = var.app_name
  sqs_company_reports_name      = module.sqs.sqs_company_reports_name
  sns_cloudwatch_alarms_arn     = module.cloudwatch-sns-alarms.sns_cloudwatch_alarms_arn
}

module "cloudwatch-alarms-alb" {
  source 		                    = "../../modules/cloudwatch/alarms/alb"
  environment                   = var.environment
  app_name                      = var.app_name
  region                        = var.region
  sns_cloudwatch_alarms_arn     = module.cloudwatch-sns-alarms.sns_cloudwatch_alarms_arn
  alb_backend_arn_suffix        = module.application-load-balancer.alb_backend_arn_suffix
  alb_odoo_arn_suffix           = module.application-load-balancer.alb_odoo_arn_suffix
  # alb_matching_arn_suffix       = module.application-load-balancer.alb_matching_arn_suffix
  alb_celery_arn_suffix         = module.application-load-balancer.alb_celery_arn_suffix


}
