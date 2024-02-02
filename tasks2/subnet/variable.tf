# PRIVATE SUBNET

variable "private_subnet_cidr" {
  type = list(string)
}

variable "private_subnet_tag" {
  type = list(string)
}

##===================================================================================##
# PUBLIC SUBNET
variable "public_subnet_cidr" {
  type = list(string)
}

variable "public_subnet_tag" {
  type = list(string)
}

variable "aws_az" {
  type = list(string)
}

variable "myvpc" {
  type = string
}