resource "random_string" "resource_suffix" {
  length = 5
  lower = true
  upper = false
  numeric = true
  special = false
}

resource "aws_s3_bucket" "docs_static_site" {
  bucket = "notifycal-docs-${random_string.resource_suffix.result}"
}

# resource "aws_s3_bucket_website_configuration" "this" {
#   bucket = aws_s3_bucket.docs_static_site.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "404.html"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "public_access" {
#   bucket = aws_s3_bucket.docs_static_site.id

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

data "aws_iam_policy_document" "bucket_policydoc" {
  statement {
    sid = "CloudFrontPrivateContent"

    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
    
    actions = ["s3:GetObject"]

    resources = [
      "${aws_s3_bucket.docs_static_site.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.docs_static_site.id
  policy = data.aws_iam_policy_document.bucket_policydoc.json

  # This has to go before the policy, otherwise it won't apply (or require 2 applies)
  # depends_on = [ aws_s3_bucket_public_access_block.public_access ]
}
