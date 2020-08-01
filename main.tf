

module "vpc" {
  source = "./vpc"
  region = var.region
  profile = var.profile
  name_prefix = var.name_prefix
  cidr_block = var.cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "ekscluster" {
  //depends_on =
  region = var.region
  profile = var.profile
  source = "./ekscluster"
  cluster_name = var.cluster_name
  subnet_ids = module.vpc.public_subnets
}