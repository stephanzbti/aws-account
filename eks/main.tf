data "terraform_remote_state" "vpc" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "basic-bucket-terraform"
    region = "us-east-1"
    key    = "vpc/terraform.tfstate"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source                                         = "terraform-aws-modules/eks/aws"
  version                                        = "17.18.0"
  cluster_version                                = "1.21"
  cluster_name                                   = var.cluster_name
  subnets                                        = data.terraform_remote_state.vpc.outputs.private_subnets
  vpc_id                                         = data.terraform_remote_state.vpc.outputs.vpc_id
  cluster_enabled_log_types                      = var.cluster_enabled_log_types
  worker_groups_launch_template                  = var.worker_groups_launch_template
  write_kubeconfig                               = false
  map_roles                                      = var.map_roles
  cluster_endpoint_private_access                = true
  cluster_endpoint_public_access                 = true # Never enable this configuration on Production Environment - It is active because I don't have VPN to my AWS Account. (Sorry)
  enable_irsa                                    = true
  cluster_create_endpoint_private_access_sg_rule = true
}
