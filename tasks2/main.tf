resource "aws_s3_bucket" "s3_bucket_demo_new" {
  bucket = var.bucket_name
}

resource "aws_dynamodb_table" "dynamo_db_table" {
  name = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

module "vpc" {
  source = "./vpc"
  vpc_cidr = var.vpc_cidr
  instance_tenency = var.instance_tenency
  vpc_tag = var.vpc_tag
}
module "subnet" {
  source = "./subnet"
  myvpc = module.vpc.vpc_id_out
  public_subnet_cidr = var.public_subnet_cidr
  aws_az = var.aws_az
  public_subnet_tag = var.public_subnet_tag
  private_subnet_cidr = var.private_subnet_cidr
  private_subnet_tag = var.private_subnet_tag
}
module "igw" {
  source = "./igw"
  myvpc = module.vpc.vpc_id_out
  igw_tag = var.igw_tag
}

module "nat" {
  source = "./nat"
  eip_nat = module.nat.eip_out
  public_subnets = module.subnet.public_subnet_out
  nat_tag = var.nat_tag
}
module "route_table" {
  source = "./routetable"
  myvpc = module.vpc.vpc_id_out
  cidr_blocks = var.cidr_blocks
  myigw = module.igw.igw_out
  mynat = module.nat.nat_out
  public_subnets = module.subnet.public_subnet_out
  public_route_tag = var.public_route_tag
  private_subnets = module.subnet.private_subnet_out
  private_route_tag = var.private_route_tag
}

module "ami_image" {
  source = "./ami"
  ami_image_flavor = var.ami_image_flavor
  ami_image_virt_type = var.ami_image_virt_type
  ami_image_owner_id = var.ami_image_owner_id
}
module "key_pair" {
  source = "./key"
  public_key_pair = var.public_key_pair
  private_key_name = var.private_key_name
  # default_public_key = file(var.default_public_key)
}
module "sec_groups" {
  source = "./securitygroup"
  sec_groups_name = var.sec_groups_name
  myvpc = module.vpc.vpc_id_out
  ingress_ports = var.ingress_ports
  egress_ports = var.egress_ports
  cidr_blocks = [var.cidr_blocks]
}
module "instance_launch" {
  source = "./instance"
  ami_id = module.ami_image.ami_image_id_out
  instance_type = var.instance_type
  public_subnet_id = module.subnet.public_subnet_out
  private_subnet_id = module.subnet.private_subnet_out
  key = var.public_key_pair
  public_instance_tag = var.public_instance_tag
  private_instance_tag = var.private_instance_tag
  sec_groups = module.sec_groups.security_groups_out
}