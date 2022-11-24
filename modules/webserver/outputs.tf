# output "webserver_module_aws_ami_id" {
#   value = data.aws_ami.updated_ami.id
# }

output "webserver_module_aws_ec2_lab1_pubip" {
  value = resource.aws_instance.lab1.public_ip
}

output "webserver_module_instance" {
  value = aws_instance.lab1
}