# AWS Region and Availability Zone
variable "aws_region" {
  type    = string
  description = "aws region name"
}

# All traffic cidr block 
variable "cidr_blocks" {
  type = string
}
#=================================================================================#
# VPC BLOCK
variable "vpc_cidr" {
  type    = string
  description = "vpc cidr range"
}
variable "instance_tenency" {
  type    = string
  description = "instance tenency"
}
variable "vpc_tag" {
  type    = string
  description = "vpc tag name"
}
#=================================================================================#
# SUBNET BLOCK
variable "aws_az" {
  type = list(string)
}
# PRIVATE SUBNET
variable "private_subnet_cidr" {
  description = "private subnet cidr range"
  type = list(string)
}
variable "private_subnet_tag" {
  description = "private subnet names"
  type = list(string)
}
# PUBLIC SUBNET
variable "public_subnet_cidr" {
  description = "public subnet cidr range"
  type = list(string)
}
variable "public_subnet_tag" {
  description = "public subnet name"
  type = list(string)
}
#=================================================================================#
# IGW
variable "igw_tag" {
  type = string
  description = "igw gateway id"
}
#=================================================================================#
# NAT
variable "nat_tag" {
  type = string
  description = "Name of NAT gateway"
}
#=================================================================================#
# Route Table
variable "public_route_tag" {
  type = string
  description = "Name of public route table"
}
variable "private_route_tag" {
  type = string
  description = "Name of private route table"
}
#=================================================================================#
# AMI 
variable "ami_image_flavor" {
  type = string
  description = "Flavor of images ex. ubuntu"
}
variable "ami_image_virt_type" {
  type = string
  description = "Type of virtualization ex. hvm"
}
variable "ami_image_owner_id" {
  type = string
  description = "image flavor id ex. for ubuntu"
}
#=================================================================================#
# KEY PAIR
variable "public_key_pair" {
  type = string
}
variable "private_key_name" {
  type = string
}
# variable "default_public_key" {
  # type = string
# }
#=================================================================================#
# Security Groups
variable "sec_groups_name" {
  type = string
}
variable "ingress_ports" {
  description = "List of ingress/inbound ports for the security group"
  type        = list(number)
}
variable "egress_ports" {
  description = "List of egress/outbound ports for the security group"
  type        = list(number)
}
#=================================================================================#
# INSTANCE
# Instance Name
variable "public_instance_tag" {
  type = list(string)
}
variable "private_instance_tag" {
  type = list(string)
}
# Instance Type
variable "instance_type" {
  type = string
  description = "Type of instance"
}

#=================================================================================#