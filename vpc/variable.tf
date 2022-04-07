variable "region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type    = string
  default = "plana"
}

variable "azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type    = list(any)
  default = ["10.0.128.0/20", "10.0.160.0/20", "10.0.192.0/20"]
}

variable "database_subnets" {
  type    = list(any)
  default = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
}

variable "public_subnets" {
  type    = list(any)
  default = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}
