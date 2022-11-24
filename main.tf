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

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "demo_vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.az]
  public_subnets  = [var.subnet_cidr_block]
  public_subnet_tags = {
      Env: "${var.env_prefix}"
      Service: "${var.env_prefix}-subnet-demo"
      Name : "${var.env_prefix}-subnet"
      Role: "${var.env_prefix}-subnet"
      Team: "team-${var.team}"
    
    }

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-lab1-vpc-demo"
        Name : "${var.env_prefix}-vpc"
        Role: "${var.env_prefix}-vpc"
        Team: "team-${var.team}"
    
    }
}

module "demo_webserver" {
  source = "./modules/webserver"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  instance_type = var.instance_type
  ec2_ami = var.ec2_ami
  open_cidr = var.open_cidr
  vpc_cidr_block = var.vpc_cidr_block
  team = var.team
  env_prefix = var.env_prefix
  az = var.az
}