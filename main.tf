terraform {
  backend "s3" {}
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
  profile = var.profile
  name_prefix = var.name_prefix
  cidr_block = var.cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "ekscluster" {
  region = var.region
  profile = var.profile
  source = "./modules/ekscluster"
  cluster_name = var.cluster_name
  subnet_ids = module.vpc.public_subnets
}