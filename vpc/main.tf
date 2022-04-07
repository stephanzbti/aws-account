module "vpc" {
  source                             = "terraform-aws-modules/vpc/aws"
  version                            = "3.13.0"
  name                               = var.name
  cidr                               = var.cidr
  azs                                = var.azs
  private_subnets                    = var.private_subnets
  database_subnets                   = var.database_subnets
  public_subnets                     = var.public_subnets
  enable_nat_gateway                 = true
  enable_dns_support                 = true
  enable_dns_hostnames               = true
  create_database_subnet_route_table = true
}
