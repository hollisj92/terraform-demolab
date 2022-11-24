output "ec2_public_ip" {
    value = module.demo_webserver.webserver_module_instance.public_ip
}