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
}