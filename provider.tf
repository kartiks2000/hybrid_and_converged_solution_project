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
  access_key = "AKIAR7USEHHQ5D5WPUTN"
  secret_key = "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"
}