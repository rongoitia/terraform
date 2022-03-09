###########################################
# S3 Bucket
###########################################
resource "aws_s3_bucket" "s3_access_log" {
  bucket = "${var.app_name}-access-log-${var.environment}"
  acl    = "log-delivery-write"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }
  versioning {
    enabled = true
  }
  lifecycle {
    ignore_changes = [ versioning ]
  }
  tags = {
       Name      = "${var.app_name}-access-log-${var.environment}"
  }
}

resource "aws_s3_bucket_policy" "s3_access_policy" {
  bucket = aws_s3_bucket.s3_access_log.id
  policy = data.aws_iam_policy_document.s3_bucket_lb_write.json
}


data "aws_iam_policy_document" "s3_bucket_lb_write" {
  policy_id = "s3_bucket_lb_logs"
  statement {
    actions = [
      "s3:PutObject",
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.s3_access_log.arn}/*",
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }
  statement {
    actions = [
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = ["${aws_s3_bucket.s3_access_log.arn}/*"]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }
  statement {
    actions = [
      "s3:GetBucketAcl"
    ]
    effect = "Allow"
    resources = [aws_s3_bucket.s3_access_log.arn]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }
}




resource "aws_s3_bucket" "workera_secret_files" {
  bucket = "${var.name_workera_secret_files}-${var.environment}"
  acl    = var.acl_workera_secret_files
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }
  tags = {
       Name      = "${var.app_name}-${var.environment}-secret-files"
  }
}

#EC2 Kurento Media Server
#    - video-cheating-storage

