output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cidr_block" {
  value = module.vpc.cidr_block
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_subnets_cidr" {
  value = module.vpc.public_subnets_cidr
}

output "public_subnets_az" {
  value = module.vpc.public_subnets_az
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidr" {
  value = module.vpc.private_subnets_cidr
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}
//
output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

//output "python_server_sg_id" {
//  value = "${module.security_groups.python_sg_id}"
//}
//
//output "node_sg_id" {
//  value = "${module.security_groups.node_sg_id}"
//}
//
//output "loadB_sg_id" {
//  value = "${module.security_groups.lb_sg_id}"
//}
//
//
//
//output "nat_intance_server_sg_id" {
//  value = "${module.security_groups.nat_intance_sg_id}"
//}
//
//output "deliver_role_arn" {
//  value = "${module.iam.sns_role_arn}"
//}

//output "hostedzone_ns" {
//  value = "${module.hosted_zone.hosted_ns}"
//}