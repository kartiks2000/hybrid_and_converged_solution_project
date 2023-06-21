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
  access_key = "AKIA2YQ5W55K2N7SC65W"
  secret_key = "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"
}