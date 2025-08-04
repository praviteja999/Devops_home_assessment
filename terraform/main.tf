
terraform {
  backend "s3" {}
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  env    = var.env
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "${var.env}-eks"
  env          = var.env
  subnets      = module.vpc.private_subnet_ids
  vpc_id       = module.vpc.vpc_id
  oidc_provider_enabled = true
}

module "rds" {
  source     = "./modules/rds"
  env        = var.env
  db_user    = var.db_user
  db_pass    = var.db_pass
  subnet_ids = module.vpc.private_subnet_ids
}

module "s3" {
  source = "./modules/s3"
  env    = var.env
}

module "monitoring" {
  source            = "./modules/monitoring"
  env               = var.env
  rds_instance_id   = module.rds.db_instance_id
  s3_bucket_name    = module.s3.bucket_name
  slack_webhook_url = var.slack_webhook_url
}


module "iam" {
  source = "./modules/iam"
  env    = var.env
}

module "ec2_monitor" {
  source        = "./modules/ec2_monitor"
  instance_type = "t3.medium"
  key_name      = var.key_name
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_ids[0]
}

module "argocd" {
  source    = "./modules/argocd"
  namespace = "argocd"
}
