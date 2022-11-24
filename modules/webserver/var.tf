# ---------------- compute
variable "instance_type" {
    description = "instance_type"
    sensitive = true
    type = string
}
variable "ec2_ami" {
    description = "ec2_ami"
    sensitive = true
    type = string
}
# ---------------- vpc/subnet/routing
variable "vpc_cidr_block" {
    description = "vpc_cidr_block"
    sensitive = true
    type = string
}
variable "subnet_cidr_block" {
    description = "subnet_cidr_block"
    sensitive = true
    type = string
}
variable "az" {
    description = "availability zone"
    sensitive = true
    type = string
}
variable "env_prefix" {
    description = "env_prefix"
    sensitive = true
    type = string
}
# ---------------- shortcuts
variable "open_cidr" {
  description = "open cidrblock for shorthand"
    sensitive = false
    type = string
}
variable "my_ip" {
    description = "my_ip"
    sensitive = true
    type = string
}

# ---------------- common tags
variable "team" {
    description = "Team"
    sensitive = true
    type = string
}
