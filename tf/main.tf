module "docs" {
  source = "git@github.com:Notifycal/tofu-module-static-website.git?ref=v2.1.1"

  base_domain   = var.base_domain
  domain_prefix = var.domain_prefix

  enable_www_redirect = false

  cloudflare_config = {
    account_name = var.base_domain
    private_site_auth = {
      idp_name = "Github"
    }
  }
}
