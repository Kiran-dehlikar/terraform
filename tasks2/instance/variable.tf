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
# Key Pair
variable "key" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "public_subnet_id" {
  type = list(string)
}
variable "private_subnet_id" {
  type = list(string)
}
variable "sec_groups" {
  type = string
}
