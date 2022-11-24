resource "aws_instance" "lab1" {
  # ami = data.aws_ami.updated_ami.id
  # instance_type = var.instance_type
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id
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
    vpc_id = var.vpc_id
    name = "demo_sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.open_cidr]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [var.open_cidr]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.open_cidr]
        prefix_list_ids = []
    }




    tags = {
        Env: "${var.env_prefix}"
        Service: "${var.env_prefix}-lab1-secgroup-demo"
        Name : "${var.env_prefix}-secgroup"
        Role: "${var.env_prefix}-secgroup"
        Team: "team-${var.team}"
    
    }
}

# data "aws_ami" "updated_ami" {
#     most_recent = true
#     owners = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*"]
#   }

#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }
# }
