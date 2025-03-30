output "bucket_name" {
  value = module.docs.bucket_names.main
}

output "site_url" {
  value = "https://${var.domain_prefix}.${var.base_domain}"
}
