resource "aws_vpc" "demo_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
      Name : "${var.env_prefix}-vpc"
    }
}

resource "aws_subnet" "demo_subnet_1" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.az
    tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-subnet-demo"
        Name : "${var.env_prefix}-subnet1"
        Role: "${var.env_prefix}-subnet"
        Team: "team-${var.team}"
    }
}