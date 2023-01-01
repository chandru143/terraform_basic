provider "aws" {
    region = "eu-west-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = var.vpcname
  }
}
output "myvpcarn" {
  description = "My VPC arn is"
  value = aws_vpc.my_vpc.arn
}

resource "aws_security_group" "myssh" {
   name = "sshaccess"
   description = "SG to access the instance"
   vpc_id = aws_vpc.my_vpc.id

   ingress {
    description = "ssh"
    from_port = 22
    protocol = "tcp"
    self = false
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
   }
  
  ingress {
    description = "smtp"
    from_port = 25
    ipv6_cidr_blocks = [ "::/0" ]
    protocol = "tcp"
    self = false
    cidr_blocks = [ "0.0.0.0/0" ]
    to_port = 25
  }
}

resource "aws_instance" "my_instance" {
  ami = "ami-0fe0b2cf0e1f25c8a"
  instance_type = "t2.micro"
}