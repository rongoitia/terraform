
resource "aws_cloudfront_function" "security_headers" {
  name    = "security-headers-${var.environment}"
  runtime = "cloudfront-js-1.0"
  comment = "Add security header to frontend HTTP request"
  publish = true
  code    = file("${path.module}/security-headers.js")
}
