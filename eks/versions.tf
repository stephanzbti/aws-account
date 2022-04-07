terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket = "basic-bucket-terraform"
    region = "us-east-1"
    key    = "eks/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Team                               = "plana"
      Environment                        = terraform.workspace
      Terraform                          = true
      Name                               = "eks-plana"
      Proposal                           = "plana-cluster"
      Kind                               = "eks"
      "kubernetes.io/cluster/production" = "shared"
    }
  }
}
