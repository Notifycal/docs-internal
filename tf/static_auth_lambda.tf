## IAM

locals {
  function_name = "notifycal-docs-auth-lambda"
}

data "aws_iam_policy_document" "auth_lambda_assume_role_policydoc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "auth_lambda" {
  name = "notifycal-docs-auth-lambda"
  description = "Role used by Lambda@Edge"
  assume_role_policy = data.aws_iam_policy_document.auth_lambda_assume_role_policydoc.json
}

data "aws_iam_policy_document" "log_policy_document" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "auth_lambda_policy" {
  name   = "notifycal-docs-auth-lambda-log-policy"
  policy = data.aws_iam_policy_document.log_policy_document.json
}

resource "aws_iam_role_policy_attachment" "auth_lambda_role_policies" {
  policy_arn = aws_iam_policy.auth_lambda_policy.arn
  role = aws_iam_role.auth_lambda.id
}

## source code
data "archive_file" "auth_lambda_zip" {
  type        = "zip"
  output_path = "dist/auth_lambda_edge.zip"
  source_file = "${path.root}/../lambdas/static-auth.mjs"
}

resource "aws_lambda_function" "auth" {
  provider = aws.cdn

  function_name = local.function_name
  filename = data.archive_file.auth_lambda_zip.output_path
  handler = "static-auth.handler"
  source_code_hash = filebase64sha256(data.archive_file.auth_lambda_zip.output_path)

  role = aws_iam_role.auth_lambda.arn

  runtime = "nodejs20.x"
  timeout = 5
  memory_size = 128

  # These aren't supported in Lambda@Edge
  # environment {
  #   variables = {
  #     USER = "foo"
  #     PASS = "bar"
  #   }
  # }

  logging_config {
    log_group = aws_cloudwatch_log_group.auth_lambda_logs.name
    log_format = "JSON"
  }

  publish = true
}

resource "aws_cloudwatch_log_group" "auth_lambda_logs" {
  name = "/aws/lambda/${local.function_name}"
}
