variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "protocol" {
  type = string
}