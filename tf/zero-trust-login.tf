data "cloudflare_accounts" "this" {
  name = "notifycal.com"
}


data "cloudflare_access_identity_provider" "github" {
  name       = "Github"
  account_id = data.cloudflare_accounts.this.accounts[0].id
}

resource "cloudflare_zero_trust_access_application" "private_docs" {
  zone_id = data.cloudflare_zone.main.id
  name    = "${local.domain_prefix} private access"
  domain  = "${local.domain_prefix}.${local.base_domain}"
  type    = "self_hosted"

  allowed_idps = [
    data.cloudflare_access_identity_provider.github.id,
  ]
  session_duration          = "24h"
  auto_redirect_to_identity = true
}

resource "cloudflare_zero_trust_access_policy" "gh_org" {
  application_id = cloudflare_zero_trust_access_application.private_docs.id
  zone_id        = data.cloudflare_zone.main.id
  name           = "allow-gh-org"
  precedence     = "1"
  decision       = "allow"

  include {
    github {
      identity_provider_id = data.cloudflare_access_identity_provider.github.id
      name                 = "Notifycal"
    }
  }
}
