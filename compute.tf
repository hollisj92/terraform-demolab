resource "aws_instance" "lab1" {
  ami = "${data.aws_ami.updated_ami}"
  instance_type = var.instance_type
  subnet_id = aws_subnet.demo_subnet_1.id
  vpc_security_group_ids = [ aws_security_group.demo_sg.id ]
  availability_zone = var.az
  associate_public_ip_address = true

  user_data = file("entry-script.sh")

  # provisioner "file" {
  #   source = "entry-script.sh"
  #   destination = "/home/ec2-user/ec2-entry-script.sh"
  # }

  # provisioner  "remote-exec" {
  #   script = file("ec2-entry-script.sh")
  # }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > output.txt"
    
  }
  
  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-lab-demo"
        Name : "${var.env_prefix}-Lab1"
        Role: "${var.env_prefix}-webserver"
        Team: "team-${var.team}"
    
    }
}

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
  value = data.aws_ami.updated_ami.id
}