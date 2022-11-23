resource "aws_route_table" "demo_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = var.open_cidr
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
          Env: "${var.env_prefix}"
          Service: "${var.env_prefix}-route_tbl-demo"
          Name : "${var.env_prefix}-route_tbl"
          Role: "${var.env_prefix}-route_tbl"
          Team: "team-${var.team}"
      
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-igw-demo"
        Name : "${var.env_prefix}-igw"
        Role: "${var.env_prefix}-igw"
        Team: "team-${var.team}"
    
  }
}

resource "aws_route_table_association" "subnet_2_rtbl_assc" {
  subnet_id      = aws_subnet.demo_subnet_1.id
  route_table_id = aws_route_table.demo_route_table.id
}

