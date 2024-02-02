aws_region = "ap-northeast-1"
aws_az = [ "ap-northeast-1a","ap-northeast-1c" ]
#=================================================================================#
# AMI 
ami_image_flavor = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
#["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
ami_image_virt_type = "hvm"
ami_image_owner_id = "099720109477" # Canonical
#=================================================================================#
# VPC
cidr_blocks = "0.0.0.0/0"
vpc_cidr = "10.0.0.0/16"
instance_tenency = "default"
vpc_tag = "tf-vpc"
#=================================================================================#
# SUBNET
private_subnet_cidr = ["10.0.0.0/18","10.0.64.0/18"]
public_subnet_tag = ["tf-pub-subnet-1","tf-pub-subnet-2"]
public_subnet_cidr = ["10.0.128.0/18","10.0.192.0/18"]
private_subnet_tag = ["tf-pri-subnet-1","tf-pri-subnet-2"]
#=================================================================================#
# IGW Gateway
igw_tag = "tf-igw"
#=================================================================================#
# NAT Gateway
nat_tag = "tf-nat"
#=================================================================================#
# Route table
public_route_tag = "tf-public-route"
private_route_tag = "tf-private-route"
#=================================================================================#
# KEY PAIR 
public_key_pair = "tokyo_key"
private_key_name = "tokyo_key.pem"
# default_public_key = "~/.ssh/id_rsa.pub" # Replace with the path to your public key
#=================================================================================#
# SECURITY GROUP
sec_groups_name = "tf-sg"
ingress_ports = [22,80]
egress_ports = [0]
#=================================================================================#
# INSTANCE 
public_instance_tag = [ "tf-public-1","tf-public-2"]
private_instance_tag = ["tf-private-1","tf-private-2" ]
instance_type = "t2.micro"

#=================================================================================#