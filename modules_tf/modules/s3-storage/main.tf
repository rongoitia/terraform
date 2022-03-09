###########################################
# S3 Bucket
###########################################
resource "aws_s3_bucket" "sensei_resumes" {
  bucket = "${var.name_sensei_resumes}-${var.environment}"
  acl    = var.acl_sensei_resumes
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }
  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = "s3-${var.name_sensei_resumes}/${var.name_sensei_resumes}-${var.environment}"
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-sensei-resumes-s3"
  }
}

resource "aws_s3_bucket" "workera_downloadable_files" {
  bucket = "${var.name_workera_downloadable_files}-${var.environment}"
  acl    = var.acl_workera_downloadable_files
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }
  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = "s3-${var.name_workera_downloadable_files}/${var.name_workera_downloadable_files}-${var.environment}"
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-workera-downloadable-files-s3"
  }
}

resource "aws_s3_bucket" "workera_certificates" {
  bucket = "${var.name_workera_certificates}-${var.environment}"
  acl    = var.acl_workera_certificates
  cors_rule {
          allowed_headers = [
              "*",
            ]
          allowed_methods = [
              "GET",
            ]
          allowed_origins = [
              "*",
            ]
          expose_headers  = []
          max_age_seconds = 3000
  }
  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = "s3-${var.name_workera_certificates}/${var.name_workera_certificates}-${var.environment}"
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-workera-certificates-s3"
  }
}

resource "aws_s3_bucket_policy" "workera_certificates_policy" {
  bucket = aws_s3_bucket.workera_certificates.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
             "s3:GetObject"
          ],
          "Resource": [
             "arn:aws:s3:::${aws_s3_bucket.workera_certificates.id}/*"
          ]
      }
    ]
}
POLICY
}

resource "aws_s3_bucket" "reach_ai_media" {
  bucket = "${var.name_reach_ai_media}-${var.environment}"
  acl    = var.acl_reach_ai_media
  cors_rule {
          allowed_headers = [
              "*",
            ]
          allowed_methods = [
              "GET",
            ]
          allowed_origins = [
              "*",
            ]
          expose_headers  = []
          max_age_seconds = 3000
    }
  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = "s3-${var.name_reach_ai_media}/${var.name_reach_ai_media}-${var.environment}"
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-reach-ai-media-s3"
  }
}
resource "aws_s3_bucket" "mlp_matching_results" {
  bucket = "${var.name_mlp_matching_results}-${var.environment}"
  acl    = var.acl_mlp_matching_results
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }
  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = "s3-${var.name_mlp_matching_results}/${var.name_mlp_matching_results}-${var.environment}"
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-mlp-s3"
  }
}

resource "aws_s3_bucket" "workera_public_sources" {
  bucket = "${var.name_workera_public_sources}-${var.environment}"
  acl    = var.acl_workera_public_sources
  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = "s3-${var.name_workera_public_sources}/${var.name_workera_public_sources}-${var.environment}"
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-workera-public-sources-s3"
  }
}

resource "aws_s3_bucket" "company_reports" {
  bucket = "${var.name_company_reports}-${var.environment}"

  grant {
    id          = var.cloudfront_oai_canonical_id
    type        = "CanonicalUser"
    permissions = ["READ", "READ_ACP"]
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = "s3-${var.name_company_reports}/${var.name_company_reports}-${var.environment}"
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-company-reports-s3"
  }
}

resource "aws_s3_bucket" "app_files" {
  bucket = "${var.name_app_files}-${var.environment}"
  acl    = var.acl_app_files
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }
  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = "s3-${var.name_app_files}/${var.name_app_files}-${var.environment}"
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-app-files-s3"
  }
}