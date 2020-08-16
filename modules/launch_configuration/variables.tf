variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "app_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "image_id" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "managed_policies" {
  type = list(string)
}