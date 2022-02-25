terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }
  }

  required_version = ">= 0.13.1"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source    = "./modules/vpc"
  namespace = var.namespace
}

module "ssh-key" {
  source    = "./modules/ssh-key"
  namespace = var.namespace
}

module "s3" {
  source    = "./modules/s3"
  namespace = var.namespace
}

module "iam-policy" {
  source    = "./modules/iam-policy"
  namespace = var.namespace
}

module "ec2" {
  source           = "./modules/ec2"
  namespace        = var.namespace
  ec2_subnet_id    = module.vpc.ec2_subnet_id
  sg_pub_id        = module.vpc.sg_pub_id
  key_name         = module.ssh-key.key_name
  ec2_profile_name = module.iam-policy.ec2_profile_name
}