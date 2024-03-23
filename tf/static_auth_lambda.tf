module "lambda_edge_auth" {
  source = "terraform-aws-modules/lambda/aws"
  version = "~> 7.2"

  function_name = "notifycal-docs-auth-lambda"
  description   = "Lambda@Edge for basic HTTP auth against docs website"
  source_path = "../lambdas/static-auth"

  runtime       = "nodejs20.x"
  timeout = 5
  memory_size = 128
  handler       = "static-auth.handler"
  
  lambda_at_edge = true
  lambda_at_edge_logs_all_regions = true

  logging_log_format = "JSON"

  attach_policy_statements = true
  policy_statements = {
    get_ssm_user_pass = {
      actions = [ "ssm:GetParameter" ]
      resources = [ aws_ssm_parameter.docs_auth_password.arn ]
      effect = "Allow"
    }
  }

  providers = {
    aws = aws.cdn
  }
}
