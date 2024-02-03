# AWS Region and Availability Zone
variable "aws_region" {
  type    = string
}

# All traffic cidr block 
variable "cidr_blocks" {
  type = string
}
#=================================================================================#
# VPC BLOCK
variable "vpc_cidr" {
  type    = string
}
variable "instance_tenency" {
  type    = string
}
variable "vpc_tag" {
  type    = string
}
#=================================================================================#
# SUBNET BLOCK
variable "aws_az" {
  type = list(string)
}
# PRIVATE SUBNET
variable "private_subnet_cidr" {
  type = list(string)
}
variable "private_subnet_tag" {
  type = list(string)
}
# PUBLIC SUBNET
variable "public_subnet_cidr" {
  type = list(string)
}
variable "public_subnet_tag" {
  type = list(string)
}
#=================================================================================#
# IGW
variable "igw_tag" {
  type = string
}
#=================================================================================#
# NAT
variable "nat_tag" {
  type = string
}
#=================================================================================#
# Route Table
variable "public_route_tag" {
  type = string
}
variable "private_route_tag" {
  type = string
}
#=================================================================================#
# AMI 
variable "ami_image_flavor" {
  type = string
}
variable "ami_image_virt_type" {
  type = string
}
variable "ami_image_owner_id" {
  type = string
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
  type        = list(number)
}
variable "egress_ports" {
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
}
#=================================================================================#
# S3 Bucket
variable "bucket_name" {
  type = string
}
#=================================================================================#
# DynamoDB 
variable "dynamodb_table_name" {
  type = string
}