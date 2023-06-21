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
  access_key = "AKIAWCJA2J4VHTDCJSG3"
  secret_key = "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"
}