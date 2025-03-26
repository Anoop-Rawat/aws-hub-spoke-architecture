# modules/shared-services/variables.tf

variable "vpc_id" {}
variable "environment" {}
variable "vpc_cidr" {}
variable "public_subnet_ids" {  # Add this new variable
  type        = list(string)
  description = "List of public subnet IDs from the hub VPC"
}

