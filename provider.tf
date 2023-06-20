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
  access_key = "AKIAVP5EAAGLFSHOUMLL"
  secret_key = "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"
}