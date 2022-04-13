resource "aws_route_table" "rtb_1" {
  vpc_id = aws_vpc.vpc_1.id
  route{
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw_1.id
  }
  tags = {
      "Name"="rtb_1"
  }
}

resource "aws_internet_gateway" "igw_1" {
  vpc_id = aws_vpc.vpc_1.id
  tags = {
      "Name":"igw_1"
  }
}

resource "aws_route_table_association" "rtb_assn" {
  route_table_id = aws_route_table.rtb_1.id 
  subnet_id = aws_subnet.subnet_vpc_1.id
}