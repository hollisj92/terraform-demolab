resource "aws_security_group" "demo_sg" {
    vpc_id = aws_vpc.demo_vpc.id
    name = "demo_sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.my_ip
    }

      tags = {
        Name : "${var.env_prefix}-secg"
    }
  
}