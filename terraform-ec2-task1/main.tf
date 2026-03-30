provider "aws" {
    region = "us-east-2"
  
}
# vpc
resource "aws_vpc" "my-vpc" {
    cidr_block = var.cidr_block
    tags = {
      Name = "my-vpc"
    }
  
}

#public subnet
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true


    tags = {
      Name = "public-subnet"
    }
  
}
#private subnet
resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.private_subnet_cidr
    map_public_ip_on_launch = false

    tags = {
      Name = "private-subnet"
    }
  
}

#internet gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "My-igw"

    }
  
}
#route table
resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
    }
    tags = {
      Name = "My-rt"
    }
  
}
#route table association
resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.my-rt.id
  
}
resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#instance creation
resource "aws_instance" "my-vpc-server" {
    ami = "ami-07062e2a343acc423"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.my-sg.id]
    key_name               = "vpc-key-us-east2"

    user_data = file("user_data.sh")
    tags = {
      Name = "My-vpc-server"
    }
  
}
