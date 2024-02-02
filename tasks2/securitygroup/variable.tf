# Security Groups

variable "ingress_ports" {
  type        = list(number)
}
variable "egress_ports" {
  type        = list(number)
}
variable "cidr_blocks" {
  type        = list(string)
}
variable "myvpc" {
  type = string
}
variable "sec_groups_name" {
  type = string
}