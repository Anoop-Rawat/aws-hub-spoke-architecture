# provider.tf
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "backend-statefile1"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}