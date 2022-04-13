
#   create security group for ec-2
#
variable "my_ip" {}
variable "ami" {}
variable "inst_type" {}


resource "aws_security_group" "ec2-sg" {
  name = "ec2-sg"
  vpc_id = aws_vpc.vpc_1.id
  ingress{
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks =  [ var.my_ip ]
  }
  ingress{
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress{
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      prefix_list_ids = []
  }

  tags = {
    "Name" = "tf-ec2-sg"
  }
}

output "ami_name" {
  value = aws_instance.ec2_1.ami
}

output "ec2_ip" {
  value = aws_instance.ec2_1.public_ip
}

resource "aws_instance" "ec2_1" {
  ami = var.ami
  instance_type = var.inst_type
  

  subnet_id = aws_subnet.subnet_vpc_1.id
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  availability_zone = "ap-south-1a"
  
  associate_public_ip_address = true

  key_name = "tf_key_pair" #generated from ec2 dashboard

  user_data = <<EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y docker
                sudo systemctl start docker
                sudo usermod -aG docker ec2-user
                docker container run -p 8080:80 nginx
                EOF

  tags={
      "Name" = "Terraform ec2 instance"
  }
} 