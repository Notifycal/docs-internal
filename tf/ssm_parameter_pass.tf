resource "random_password" "docs_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "docs_auth_password" {
  name  = "/notifycal/internal_docs/password"
  type  = "SecureString"
  value = random_password.docs_password.result
}
