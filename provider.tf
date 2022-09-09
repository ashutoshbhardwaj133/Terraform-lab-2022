terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  # Configuration options
  region     = "us-east-1"
  access_key = "AKIAWXWT4TZ3EW2DGVK2"
  secret_key = "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"
}
