resource "aws_route_table" "demo_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = var.open_cidr
    gateway_id = aws_internet_gateway.demo_igw.id
  }

   tags = {
        Name : "${var.env_prefix}-route_tbl"
    }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
        Name : "${var.env_prefix}-igw"
    }
}