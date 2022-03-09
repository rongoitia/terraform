###########################################
# S3 Bucket WEBSITE
###########################################
resource "aws_s3_bucket" "workera_frontend_website" {
  bucket = "${var.name_workera_frontend_website}-${var.environment}"
  acl    = var.acl_workera_frontend_website

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  versioning {
    enabled = true
  }

  tags = {
       Name      = "${var.app_name}-${var.environment}-workera-frontend"
  }
}

resource "aws_s3_bucket_policy" "workera_frontend_website_policy" {
  bucket = aws_s3_bucket.workera_frontend_website.id
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
             "arn:aws:s3:::${aws_s3_bucket.workera_frontend_website.id}/*"
          ]
      }
    ]
}
POLICY
}

