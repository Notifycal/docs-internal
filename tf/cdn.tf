# Yes, an empty resource
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Restricts access to the S3 bucket other than from CloudFront"
}

## FUUUUUCKIN HELL
### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_continuous_deployment_policy

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.docs_static_site.bucket_domain_name
    origin_id   = "s3"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

    # origin {
    #   domain_name         = aws_s3_bucket_website_configuration.this.website_endpoint
    #   origin_id           = "s3"

    #   custom_origin_config {
    #     http_port                = 80
    #     https_port               = 443
    #     origin_protocol_policy   = "http-only"
    #     origin_read_timeout      = 30
    #     origin_ssl_protocols     = [
    #       "SSLv3",
    #       "TLSv1",
    #       "TLSv1.1",
    #       "TLSv1.2",
    #     ]
    #   }
    # }
  # origin {
  #   domain_name = module.apigw_origin.domain_name
  #   origin_id   = "apigw"
  #   origin_path = module.apigw_origin.stage_path

  #   custom_origin_config {
  #     http_port              = 80
  #     https_port             = 443
  #     origin_protocol_policy = "https-only"
  #     origin_ssl_protocols   = ["TLSv1.2"]
  #   }
  # }
  
    logging_config {
      bucket = aws_s3_bucket.cdn_logs.bucket_domain_name
      include_cookies = false
    }


  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html
  price_class = "PriceClass_100"

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    # allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3"

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = aws_lambda_function.auth.qualified_arn
    }

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
      headers = [
        "Authorization"
      ]
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    # Use Cloudfront default cert for now
    cloudfront_default_certificate = true
  }
}
