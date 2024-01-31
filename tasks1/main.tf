#=====================================================================#
#======================= Create VPC ==================================#
resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr_vpc
  instance_tenancy = var.instance_tenency

  tags = {
    Name = var.vpc_tag
  }
}
#=====================================================================#
#======================= Create Subnet================================#

#=> PUBLIC SUBNET
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = element(var.aws_az, count.index % length(var.aws_az))
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_tag[count.index]
  }
}
# output "public_subnet_ids" {
  # value = aws_subnet.public_subnets[*].id
# }

#=====================================================================#
#=> PRIVATE SUBNET
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr)

  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.private_subnet_cidr[count.index]
  availability_zone       = element(var.aws_az, count.index % length(var.aws_az))
  map_public_ip_on_launch = false
  tags = {
    Name = var.private_subnet_tag[count.index]
  }
}

# output "private_subnet_ids" {
  # value = aws_subnet.private_subnets[*].id
# }

#=====================================================================#
#========================== Create IGW ===============================#
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = var.igw
  }
}

# resource "aws_internet_gateway_attachment" "myigw_attach" {
#   internet_gateway_id = aws_internet_gateway.myigw.id
#   vpc_id              = aws_vpc.myvpc.id
# }
#=====================================================================#
#===================== Create NAT Gateway ============================#

# Elastic IP (EIP) for NAT Gateway
resource "aws_eip" "nat_eip" {
  instance = null
}

resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = var.nat
  }
}

#=====================================================================#
#================== Create Route Table ===============================#
# Public Route table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = var.cidr_blocks[0]
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = var.private_route_tag
  }
}

# Associate Public Route Table with Public Subnets
resource "aws_route_table_association" "public_subnet_association" {
  count  = length(aws_subnet.public_subnets)
  subnet_id     = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

#=====================================================================#
# Private Route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = var.cidr_blocks[0]
    gateway_id = aws_nat_gateway.mynat.id
  }
  tags = {
    Name = var.private_route_tag
  }
}
# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private_subnet_association" {
  count  = length(aws_subnet.private_subnets)
  subnet_id     = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

#=====================================================================#
#================== Create EC2 Instance ==============================#

# Security Group for Instances
resource "aws_security_group" "my_security_group" {
  name        = "tf-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.egress_ports

    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = var.cidr_blocks
    }
  }
}
# AWS AMI for Instances
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    #values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Public EC2 Instance
resource "aws_instance" "public_instance" {
  count                  = length(aws_subnet.public_subnets)
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnets[count.index].id
  key_name               = var.key  # Change this to your key pair name
  associate_public_ip_address = true
  security_groups = [ aws_security_group.my_security_group.id ]

  tags = {
    count = length(var.public_instance_tag)
    Name = var.public_instance_tag[count.index]
  }
}

# Private EC2 Instance
resource "aws_instance" "private_instance" {
  count                  = length(aws_subnet.private_subnets)
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnets[count.index].id
  key_name               = var.key  # Change this to your key pair name
  associate_public_ip_address = false
  security_groups = [ aws_security_group.my_security_group.id ]

  tags = {
    count = length(var.private_instance_tag)
    Name = var.private_instance_tag[count.index]
  }
}
