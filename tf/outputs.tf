output bucket_name {
  value = aws_s3_bucket.docs_static_site.id
}

# output site_url {
#   value = "http://${aws_s3_bucket_website_configuration.this.website_endpoint}"
# }
