terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIATD3YGFEZWOHQTANG"
  secret_key = "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"
}