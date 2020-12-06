variable "instance_type" {}

# EC2
resource "aws_instance" "example" {
  ami           = data.aws_ami.recent_amazon_linux_2.image_id
  instance_type = var.instance_type
  subnet_id = "${aws_subnet.ap-northeast-1a-public.id}"
  vpc_security_group_ids = [ aws_security_group.example_ec2.id ]
  tags = {
    Name = "example"
  }
  # apacheをインストール
  user_data = file("./user_data.sh")
}

# VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "example"
  }
}

# Subnet
resource "aws_subnet" "ap-northeast-1a-public" {
  vpc_id = "${aws_vpc.example.id}"
  cidr_block = "10.0.1.0/25"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "example"
  }
}

# Security-Group
resource "aws_security_group" "example_ec2" {
  name = "example-ec2"
  vpc_id = "${aws_vpc.example.id}"

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

data "aws_ami" "recent_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

output "public_dns" {
  value = "${aws_instance.example.public_dns}"
}