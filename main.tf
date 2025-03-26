# main.tf
module "hub_vpc" {
  source             = "./modules/vpc"
  name               = "hub"
  environment        = terraform.workspace
  vpc_cidr           = terraform.workspace == "dev" ? "10.0.0.0/16" : "10.2.0.0/16"
  public_subnet_cidrs = terraform.workspace == "dev" ? ["10.0.1.0/24", "10.0.2.0/24"] : ["10.2.1.0/24", "10.2.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "spoke_vpc" {
  source             = "./modules/vpc"
  name               = "spoke"
  environment        = terraform.workspace
  vpc_cidr           = terraform.workspace == "dev" ? "10.1.0.0/16" : "10.3.0.0/16"
  public_subnet_cidrs = terraform.workspace == "dev" ? ["10.1.1.0/24", "10.1.2.0/24"] : ["10.3.1.0/24", "10.3.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "shared_services" {
  source           = "./modules/shared-services"
  vpc_id           = module.hub_vpc.vpc_id
  environment      = terraform.workspace
  vpc_cidr         = terraform.workspace == "dev" ? "10.0.0.0/16" : "10.2.0.0/16"
  public_subnet_ids = module.hub_vpc.public_subnet_ids  # Pass public subnet IDs
}

module "vpc_peering" {
  source       = "./modules/vpc-peering"
  hub_vpc_id   = module.hub_vpc.vpc_id
  spoke_vpc_id = module.spoke_vpc.vpc_id
  hub_name     = "hub"
  spoke_name   = "spoke"
}