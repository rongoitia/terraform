###########################################
# S3 Bucket WEBSITE
###########################################
resource "aws_s3_bucket" "workera_frontend_redirect" {
  bucket = var.name_workera_frontend_redirect
  acl    = var.acl_workera_frontend_redirect

  website {
    redirect_all_requests_to = var.frontend_endpoint
  }

  versioning {
    enabled = true
  }

  logging {
    target_bucket = var.s3_access_log_name
    target_prefix = var.name_workera_frontend_redirect
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-workera-redirect"
  }
}

resource "aws_s3_bucket_policy" "workera_frontend_redirect_policy" {
  bucket = aws_s3_bucket.workera_frontend_redirect.id
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
             "arn:aws:s3:::${aws_s3_bucket.workera_frontend_redirect.id}/*"
          ]
      }
    ]
}
POLICY
}

