variable "vpc_cidr" {}
variable "subnet_cidr" {}

resource "aws_vpc" "vpc_1" {
  tags = {
    "Name" = "vpc_1"
  }
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnet_vpc_1" {
  vpc_id = aws_vpc.vpc_1.id
  cidr_block = var.subnet_cidr
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "subnet_1"
  }
}