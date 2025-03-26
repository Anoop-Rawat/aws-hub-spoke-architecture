# provider.tf
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}