
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "report_bucket_policy" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}
