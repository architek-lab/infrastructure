
variable "environment" {
  type    = string
  default = "production"
}

variable "project" {
  type        = string
  default     = "architek"
  description = "name of project owner"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "team" {
  type    = string
  default = "data-platform"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "vpc" {
  type    = string
  default = "architek-vpc"
}

