resource "aws_security_group" "demo_sg" {
    vpc_id = aws_vpc.demo_vpc.id
    name = "demo_sg"

      tags = {
        Name : "${var.env_prefix}-secg"
    }
  
}