locals {
  base_domain = "notifycal.com"
  domain_prefix = "docs-internal"
}

resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  numeric = true
  special = false
}

data "cloudflare_zone" "main" {
  name = local.base_domain
}

module "docs" {
  source = "git@github.com:Notifycal/tofu-module-static-website.git?ref=v1.0.1"

  bucket_name = "${local.domain_prefix}.${local.base_domain}"

  enable_www_redirect = false
  enable_s3_public_access = false
}

resource "cloudflare_record" "main" {
  zone_id = data.cloudflare_zone.main.id
  # @ is how Cloudflare calls the naked domain
  name    = local.domain_prefix
  content = module.docs.site_urls.main
  type    = "CNAME"
  proxied = true
}
