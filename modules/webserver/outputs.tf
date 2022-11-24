output "aws_ami_id" {
  value = data.aws_ami.updated_ami.id
}

output "aws_ec2_lab1_pubip" {
  value = resource.aws_instance.lab1.public_ip
}