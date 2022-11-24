terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "demo_webserver" {
  source = "./modules/webserver"
  instance_type = var.instance_type
  ec2_ami = var.ec2_ami
  open_cidr = var.open_cidr
  vpc_cidr_block = var.vpc_cidr_block
  team = var.team
  env_prefix = var.env_prefix
  az = var.az
  subnet_cidr_block = var.subnet_cidr_block
}