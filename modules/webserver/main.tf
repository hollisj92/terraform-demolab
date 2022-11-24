resource "aws_instance" "lab1" {
  ami = data.aws_ami.updated_ami.id
  instance_type = var.instance_type
  subnet_id = module.routing.routing_module_subnet.id
  vpc_security_group_ids = [ aws_security_group.demo_sg.id ]
  availability_zone = var.az
  associate_public_ip_address = true

  user_data = file("entry-script.sh")

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > output.txt"
    
  }
  
  tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-lab-demo"
        Name : "${var.env_prefix}-lab1"
        Role: "${var.env_prefix}-webserver"
        Team: "team-${var.team}"
    
    }
}

resource "aws_security_group" "demo_sg" {
    vpc_id = module.routing.routing_module_vpc.id
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
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

}

module "routing" {
  source = "../routing"
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  az = var.az
  env_prefix = var.env_prefix
  team = var.team
  open_cidr = var.open_cidr
  my_ip = var.my_ip
  instance_type = var.instance_type
  ec2_ami = var.ec2_ami

}