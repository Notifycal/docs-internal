provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project    = var.project
      Region     = var.aws_region
      Managed-By = "Terragrunt"
      Stack      = var.stack
    }
  }
}

provider "aws" {
  alias  = "cdn"
  region = "us-east-1"

  default_tags {
    tags = {
      Project    = var.project
      Region     = "us-east-1"
      Managed-By = "Terragrunt"
      Stack      = var.stack
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

terraform {
  required_version = ">= 1.8.7"

  backend "s3" {
    bucket         = "tofu-state-notifycal-docs-internal"
    dynamodb_table = "tofu-lock-notifycal-docs-internal"
    encrypt        = true
    key            = "terraform.tfstate"
    region         = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
