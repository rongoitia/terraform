data "archive_file" "lambda_zip_file_request" {
  type        = "zip"
  output_path = "${path.module}/function.zip"
  source {
    content  = <<EOF

exports.handler = async (event, context, callback) => {
    let request = event.Records[0].cf.request;
    let requestUri = request.uri;
    // console.log("Old URI: " + requestUri);

    const isResource = requestUri.split(/[#?]/)[0].split('.').pop().trim() !== requestUri.split(/[#?]/)[0];
    if (isResource) {
      return callback(null, request);
    }

    const isEnterprise = requestUri.indexOf("/app/enterprise") !== -1;
    if (isEnterprise) {
      request.uri = '/app/enterprise/index.html';
      return callback(null, request);
    }

    const uriParts = requestUri.split("?");
    let initialUrl = uriParts[0];
    if (initialUrl.charAt(initialUrl.length-1) !== '/') {
      initialUrl += "/";
    }
    const completeUrl = initialUrl;
    if (uriParts.length > 1) {
      completeUrl += "?" + uriParts[1];
    }
    const newUri = completeUrl.replace(/\/$/, '\/index.html');

    // console.log("New URI: " + newUri);
    request.uri = newUri;
    return callback(null, request);
};

EOF
    filename = "index.js"
  }
}


resource "aws_lambda_function" "lambda_cloudfront_request" {
  function_name     = "${var.name}-cloudfront-request"
  role              = var.lambda_role_arn
  handler           = "index.handler"
  runtime           = "nodejs14.x"
  publish           = true
  filename          = data.archive_file.lambda_zip_file_request.output_path
  source_code_hash  = data.archive_file.lambda_zip_file_request.output_base64sha256
#  source_code_hash  = filebase64sha256("${path.module}/function.zip")
#  filename          = "${path.module}/function.zip"
}


data "archive_file" "lambda_zip_file_web_redirect" {
  type        = "zip"
  output_path = "${path.module}/function_redirect.zip"
  source {
    content  = <<EOF

exports.handler = async (event,context) => {

    const request = event.Records[0].cf.request;
    const requestUri = request.uri;
    let response = event.Records[0].cf.response;
    const statusCode = parseInt ( response.status );

    const isWeb = requestUri === '/web/index.html';
    if (isWeb && (statusCode == 404 || statusCode == 403) ) {
      response['headers']['location'] = [{'key': 'Location', 'value': 'https://${var.odoo_subdomain}.${var.main_domain}'}]
      response.status = 301;
    }
    return response;
};

EOF
    filename = "index.js"
  }
}


resource "aws_lambda_function" "lambda_cloudfront_web_redirect" {
  function_name     = "${var.name}-cloudfront-web-redirect"
  role              = var.lambda_role_arn
  handler           = "index.handler"
  runtime           = "nodejs14.x"
  publish           = true
  filename          = data.archive_file.lambda_zip_file_web_redirect.output_path
  source_code_hash  = data.archive_file.lambda_zip_file_web_redirect.output_base64sha256
#  source_code_hash  = filebase64sha256("${path.module}/function.zip")
#  filename          = "${path.module}/function.zip"
}