terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket = "{BUCKET_USED_TO_STORE_TERRAFORM_STATE}"
    region = "us-east-1"
    key    = "vpc/terraform.tfstate"
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
      Name                               = "vpc-plana"
      Proposal                           = "plana-cluster"
      Kind                               = "vpc"
      "kubernetes.io/cluster/production" = "shared"
    }
  }
}
