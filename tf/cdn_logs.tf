resource "aws_s3_bucket" "cdn_logs" {
  bucket = "notifycal-docs-cdn-logs"
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.cdn_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

module "cdn_logs" {
  source = "git@github.com:Notifycal/tofu-module-cdn-cloudwatch-logs.git?ref=v0.1.0"

  prefix = "notifycal-docs"

  cloudfront_log_bucket = aws_s3_bucket.cdn_logs.id
  cloudfront_distribution_id = aws_cloudfront_distribution.cdn.id
}
