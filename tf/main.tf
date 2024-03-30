resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  numeric = true
  special = false
}

module "docs" {
  source = "git@github.com:Notifycal/tofu-module-static-website.git?ref=v0.1.1"

  bucket_name = "notifycal-docs-${random_string.resource_suffix.result}"
  enable_cdn  = true

  cf_default_cache_behavior = {
    default_ttl = 86400
    max_ttl     = 31536000

    forwarded_headers = ["Origin", "Authorization"]
  }

  cf_lambda_associations = {
    origin-request = {
      lambda_arn = module.lambda_edge_auth.lambda_function_qualified_arn
    }
  }

  cf_logging_config = {
    bucket = aws_s3_bucket.cdn_logs.bucket_domain_name
  }
}
