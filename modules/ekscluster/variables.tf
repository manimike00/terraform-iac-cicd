variable "cluster_name" {
  default = "example"
  type    = string
}

variable "subnet_ids" {
  type = list(string)
  default = []
}

variable "region" {
  type = string
}

variable "profile" {
  type = string
}