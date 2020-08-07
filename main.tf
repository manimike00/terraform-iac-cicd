//terraform {
//  backend "s3" {}
//}

//module "vpc" {
//  source = "./modules/vpc"
//  region = var.region
//  profile = var.profile
//  name_prefix = var.name_prefix
//  cidr_block = var.cidr_block
//  public_subnet_cidrs = var.public_subnet_cidrs
//  private_subnet_cidrs = var.private_subnet_cidrs
//}
//
//module "ekscluster" {
//  region = var.region
//  profile = var.profile
//  source = "./modules/ekscluster"
//  cluster_name = var.cluster_name
//  subnet_ids = module.vpc.public_subnets
//}


module "owasp_top_10" {
  # This module is published on the registry: https://registry.terraform.io/modules/traveloka/waf-owasp-top-10-rules

  # Open the link above to see what the latest version is. Highly encouraged to use the latest version if possible.

  source = "./modules/waf"

  # For a better understanding of what are those parameters mean,
  # please read the description of each variable in the variables.tf file:
  # https://github.com/traveloka/terraform-aws-waf-owasp-top-10-rules/blob/master/variables.tf

//  region                         = "us-east-1"
  profile                        = "admin-gen"
//  product_domain                 = "tsi"
//  service_name                   = "tsiwaf"
//  environment                    = "staging"
//  description                    = "OWASP Top 10 rules for tsiwaf"
//  target_scope                   = "global"
//  create_rule_group              = "true"
//  max_expected_uri_size          = "512"
//  max_expected_query_string_size = "1024"
//  max_expected_body_size         = "4096"
//  max_expected_cookie_size       = "4093"
//  csrf_expected_header           = "x-csrf-token"
//  csrf_expected_size             = "36"
}