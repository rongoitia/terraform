resource "aws_secretsmanager_secret" "env_vars" {
  name = "${var.name}-env"
  recovery_window_in_days = 0
    #   lifecycle {
    #         prevent_destroy = true
    # }
}

resource "aws_secretsmanager_secret_version" "env_vars_version" {
  secret_id     = aws_secretsmanager_secret.env_vars.id
  secret_string = <<EOF
  {
    "ENVIRONMENT_NAME"                  :   "${var.environment}",
    "SNS_TOPIC_ARN_CANDIDATE_PROFILE"   :   "${var.sns_topic_arn_candidate_profile_arn}",
    "SNS_TOPIC_ARN_LEARNING_STARTED"    :   "${var.sns_topic_arn_learning_started_arn}",
    "SNS_TOPIC_ARN_SKILLS_TEST"         :   "${var.sns_topic_arn_skills_test_arn}",
    "AWS_STORAGE_BUCKET_NAME"           :   "${var.s3_reach_ai_media_name}",
    "AWS_WORKERA_DOWNLOADABLE_FILES"    :   "${var.s3_workera_downloadable_files_name}",
    "AWS_WORKERA_USERS_RESUME_FILES"    :   "${var.s3_sensei_resumes_name}",
    "AWS_CERTIFICATES_BUCKET_NAME"      :   "${var.s3_workera_certificates_name}",
    "AWS_CERTIFICATES_DOMAIN"           :   "https://${var.s3_workera_certificates_regional_name}",

    "FRONTEND_BASE_URL"                 :	  "https://${var.frontend_url}",
    "ODOO_BACKOFFICE_URL"               :   "https://${var.odoo_url}",
    "SP_HOST"                           :	  "https://${var.backend_url}",

    "LAMBDA_MATCHING_ALGORITHM_URL"     :   "https://${var.matching_url}",

    "CANDIDATE_REST_URL"                :   "https://${var.backend_url}",
    "ODOO_BACKOFFICE_URL"               :   "https://${var.odoo_url}",

    "BASE_URL"                          : 	"https://${var.backend_url}",
    "REACT_APP_LOGIN_URL"	              :   "https://${var.frontend_url}/candidates/login/",
    "REACT_APP_API_BASE_URL"	          :   "https://${var.backend_url}/",
    "FRONTEND_URL"	                    :   "https://${var.frontend_url}",
    "DOWNLOAD_URL"                      :   "https://${var.download_url}",

    "CLOUDFRONT_DOMAIN"                 :   "${var.frontend_url}",

    "AWS_SQS_COMPANY_REPORTS"           :   "${var.sqs_company_reports}",
    "AWS_COMPANY_REPORTS_BUCKET_NAME"   :   "${var.s3_company_reports_name}",
    "RDS_DB_NAME"                       :   "${replace(var.environment, "-", "_")}",
    "POSTGRES_DATABASE"                 :   "${replace(var.environment, "-", "_")}",
    "S3_WORKERA_SUPPORT_LOG_BUCKET_NAME":   "${var.s3_app_files_name}",
    "PUBLIC_KEY_ID_TO_SIGN_URL"         :   "${var.public_key_id_to_sign_url}",
	  "PRIVATE_KEY_NAME_TO_SIGN_URL"      :   "${var.private_key_to_sign_url}"
  }
  EOF
}

