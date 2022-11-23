resource "aws_vpc" "demo_vpc" {
    cidr_block = var.cidr-cidr_block[0].cidr_block
    tags = {
      "Environment" = "Production"
      Name : "${var.env_prefix}-vpc"
    }
}

resource "aws_subnet" "demo_subnet-1" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.az
    tags = {
        Name : "${var.env_prefix}-subnet-1"
    }
    
}