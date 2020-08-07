### variables VPC

variable "region" {
  description = "Specify Region to be deploy"
  type        = string
  default     = "ap-south-1"
}

variable "profile" {
  description = "Specify Profile to be deploy"
  type        = string
  default     = "admin-gen"
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
  default     = "demo"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks to use for the public subnets."
  type        = list(string)
  default     = ["10.10.1.0/24","10.10.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks to use for the private subnets."
  type        = list(string)
  default     = ["10.10.2.0/24","10.10.4.0/24"]
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "availability_zones" {
  description = "The availability zones to use for subnets and resources in the VPC. By default, all AZs in the region will be used."
  type        = list(string)
  default     = []
}

##### variables EKS Cluster

variable "cluster_name" {
  type = string
  default = "demo"
}

#####
