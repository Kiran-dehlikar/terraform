##======================================================================================##
# AWS Region and Availability Zone
##======================================================================================##
variable "aws_region" {
  type    = string
  description = "aws region name"
  default = "ap-northeast-1"
}

variable "aws_az" {
  type = list(string)
  default = [ "ap-northeast-1a","ap-northeast-1c" ]
}
##======================================================================================##
# VPC BLOCK
##======================================================================================##
variable "cidr_vpc" {
  type    = string
  description = "vpc cidr range"
  default = "10.0.0.0/16"
}

variable "instance_tenency" {
  type    = string
  description = "instance tenency"
  default = "default"
}
variable "vpc_tag" {
  type    = string
  description = "vpc tag name"
  default = "tf-vpc"
}

##=====================================================================================##
# SUBNET BLOCK
##=====================================================================================##
# PRIVATE SUBNET

variable "private_subnet_cidr" {
  description = "private subnet cidr range"
  type = list(string)
  default = ["10.0.0.0/18","10.0.64.0/18"]
}

variable "private_subnet_tag" {
  description = "private subnet names"
  type = list(string)
  default = ["tf-private-subnet-1","tf-private-subnet-2"]
}

##===================================================================================##
# PUBLIC SUBNET
variable "public_subnet_cidr" {
  description = "public subnet cidr range"
  type = list(string)
  default = ["10.0.128.0/18","10.0.192.0/18"]
}

variable "public_subnet_tag" {
  description = "public subnet name"
  type = list(string)
  default = ["tf-public-subnet-1","tf-public-subnet-2"]
}


##=====================================================================================##
# IGW BLOCK
##=====================================================================================##
# IGW
variable "igw" {
  type = string
  description = "igw"
  default = "tf-igw"
}
##=====================================================================================##
# NAT BLOCK
##=====================================================================================##
# NAT
variable "nat" {
  type = string
  description = "Name of NAT gateway"
  default = "tf-nat"
}

##=====================================================================================##
# Route Table BLOCK
##=====================================================================================##
variable "public_route_tag" {
  type = string
  description = "Name of route table"
  default = "tf-public-route"
}

variable "private_route_tag" {
  type = string
  description = "Name of route table"
  default = "tf-private-route"
}
##=====================================================================================##
# Instance BLOCK
##=====================================================================================##
# AMI 
variable "ami" {
  type = string
  description = "ID of ami to launch"
  default = "ami-0f7b55661ecbbe44c"
}
# Instance Type
variable "instance_type" {
  type = string
  description = "Type of instance"
  default = "t2.micro"
}
# Key Pair
variable "key" {
  type = string
  description = "key pair name"
  default = "tokyo"
}

# Security Groups

variable "ingress_ports" {
  description = "List of ingress ports for the security group"
  type        = list(number)
  default     = [22,80]
}

variable "egress_ports" {
  description = "List of egress ports for the security group"
  type        = list(number)
  default     = [0]
}

variable "cidr_blocks" {
  description = "List of CIDR blocks for the security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Instance Name
variable "public_instance_tag" {
  type = list(string)
  default = [ "tf-public-1","tf-public-2"]
}
variable "private_instance_tag" {
  type = list(string)
  default = ["tf-private-1","tf-private-2" ]
}