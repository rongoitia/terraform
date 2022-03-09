output "lambda_cloudfront_request_arn" {
  value       = "${aws_lambda_function.lambda_cloudfront_request.arn}:${aws_lambda_function.lambda_cloudfront_request.version}"
}

output "lambda_cloudfront_web_redirect_arn" {
  value       = "${aws_lambda_function.lambda_cloudfront_web_redirect.arn}:${aws_lambda_function.lambda_cloudfront_web_redirect.version}"
}