resource "aws_security_group" "demo_sg" {
    vpc_id = aws_vpc.demo_vpc.id
    name = "demo_sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.my_ip
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = var.my_ip
    }

    egress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = var.open_cidr
    }



      tags = {
        Name : "${var.env_prefix}-secg"
    }
  
}