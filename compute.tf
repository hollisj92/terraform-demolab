# resource "aws_instance" "lab1" {
  
# }

resource "aws_security_group" "demo_sg" {
    vpc_id = aws_vpc.demo_vpc.id
    name = "demo_sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }

    egress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = [var.open_cidr]
    }



      tags = {
        Name : "${var.env_prefix}-secg"
    }
  
}

data "aws_ami" "updated_ami" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name   = "name"
      values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

}

output "aws_ami_id" {
  value = data.aws_ami.updated_ami
}