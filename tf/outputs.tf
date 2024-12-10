output "bucket_name" {
  value = module.docs.bucket_names.main
}

output "site_url" {
  value = "https://${local.domain_prefix}.${local.base_domain}"
}
