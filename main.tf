
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # you must pass your credentials with --backend-config at this point, this block does not support variables
  # best practice would be to set a variable for this bucket name - this would have to be done in the form of a module
  # in order for your s3 bucket to be handled as your s3 state you must provision the s3 bucket in your local state then use init --migrate to switch to the remote state
  # backend "s3" {
  #   bucket = "SETBUCKETNAME"
  #   key = "global/s3/terraform.tfstate"
  #   region = "us-east-1"
  #   dynamodb_table = "terraform-state-locking"
  #   encrypt = true
  # }
}

resource "aws_s3_bucket" "tf-state" {
  bucket = "SETBUCKETNAME"
  lifecycle {
    prevent_destroy = true

  }
  versioning{
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
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