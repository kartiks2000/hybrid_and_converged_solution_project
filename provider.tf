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
  access_key = "AKIA2FGCSLJULI75ZFGL"
  secret_key = "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"
}