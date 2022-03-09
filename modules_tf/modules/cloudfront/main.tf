###########################################
# Cloudfront Distribution
###########################################

resource "aws_cloudfront_origin_access_identity" "cloudfront_oai" {
  comment = "${var.environment} used to enable signed url from cloud front to report's bucket"
}

resource "aws_cloudfront_public_key" "cf_key" {
	encoded_key = var.public_key
}

resource "aws_cloudfront_key_group" "cf_keygroup" {
	items = [aws_cloudfront_public_key.cf_key.id]
	name  = "${var.environment}-group"
}

resource "aws_cloudfront_distribution" "frontend_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "workera-frontend-${var.environment}"
  default_root_object = "index.html"
  price_class         = "PriceClass_200"
  aliases             = ["${var.frontend_subdomain}.${var.main_domain}"]
  lifecycle {
    ignore_changes = [ aliases ]
  }
  logging_config {
    include_cookies   = false
    bucket            = "${var.s3_access_log_name}.s3.amazonaws.com"
    prefix            = "frontend"
  }

    restrictions {
    geo_restriction {
      restriction_type      = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn     = var.arn_certificate_cloudfront
    ssl_support_method      = "sni-only"
    minimum_protocol_version= "TLSv1.2_2021"
  }


  ###########################################
  # Origins
  ###########################################
  origin {
    domain_name = var.workera_frontend_website_regional_name
    origin_id   = var.workera_frontend_website_id
  }

  origin {
    domain_name = var.reach_ai_media_regional_name
    origin_id   = var.reach_ai_media_id
  }

  ###########################################
  # Beaviors
  ###########################################
  default_cache_behavior {
    allowed_methods         = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods          = ["GET", "HEAD"]
    target_origin_id        = var.workera_frontend_website_id

    viewer_protocol_policy  = "redirect-to-https"
    min_ttl                 = 0
    default_ttl             = 0
    max_ttl                 = 0

    forwarded_values {
      query_string          = false
      cookies {
        forward             = "none"
      }
    }

    lambda_function_association {
      event_type   = "origin-request"
      include_body = true
      lambda_arn   = var.lambda_cloudfront_request_arn
    }

    lambda_function_association {
      event_type   = "origin-response"
      #include_body = true
      lambda_arn   = var.lambda_cloudfront_web_redirect_arn
    }

    function_association {
      event_type   = "viewer-response"
      function_arn = var.cloudfront_function_security_header
    }

  }

  ordered_cache_behavior {
    path_pattern            = "/static/*"
    allowed_methods         = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods          = ["GET", "HEAD"]
    target_origin_id        = var.reach_ai_media_id

    viewer_protocol_policy  = "redirect-to-https"
    min_ttl                 = 0
    default_ttl             = 0
    max_ttl                 = 0

    forwarded_values {
      query_string          = false
      cookies {
        forward             = "none"
      }
    }

  }

    ordered_cache_behavior {
    path_pattern            = "/media/*"
    allowed_methods         = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods          = ["GET", "HEAD"]
    target_origin_id        = var.reach_ai_media_id

    viewer_protocol_policy  = "redirect-to-https"
    min_ttl                 = 0
    default_ttl             = 0
    max_ttl                 = 0

    forwarded_values {
      query_string          = false
      cookies {
        forward             = "none"
      }
    }
  }
}

resource "aws_cloudfront_distribution" "download_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "workera-download-${var.environment}"
  price_class         = "PriceClass_200"
  aliases             = ["${var.download_subdomain}.${var.main_domain}"]

  lifecycle {
    ignore_changes = [ aliases ]
  }
  logging_config {
    include_cookies   = false
    bucket            = "${var.s3_access_log_name}.s3.amazonaws.com"
    prefix            = "frontend"
  }

    restrictions {
    geo_restriction {
      restriction_type      = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn     = var.arn_certificate_cloudfront
    ssl_support_method      = "sni-only"
    minimum_protocol_version= "TLSv1.2_2021"
  }

  origin {
    domain_name = var.report_bucket_regional_name
    origin_id   = var.report_bucket_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods         = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods          = ["GET", "HEAD"]
    target_origin_id        = var.report_bucket_id

    viewer_protocol_policy  = "redirect-to-https"
    min_ttl                 = 0
    default_ttl             = 0
    max_ttl                 = 0

    trusted_key_groups      = [aws_cloudfront_key_group.cf_keygroup.id]
    forwarded_values {
      query_string          = false
      cookies {
        forward             = "none"
      }
    }
  }
}
