provider "aws" {
  region = "eu-west-1"
}

variable "vpc_name" {
  type = string
  default = "my_vpc"
}

variable "sshport" {
  type = number
  default = 22
}

variable "enabled" {
    default = true
}

variable "mylist" {
  type = list(string)
  default = [ "value1","value2" ]
}

variable "mympap" {
  type = map
  default = {
    key1 = "vaule1"
    key2 = "vaule2"
  }
}

variable "myinput" {
    type = string
    description = "Enter the vpc name"
}
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = var.myinput
    }
}
output "arn" {
  value = aws_vpc.myvpc.arn
}
variable "mytuples" {
  type = tuple([string,number,string])
  default = ["value1",22,"value2"]
}

variable "myobject" {
  type = objects({name=string,port=list(number)})
  default = {
    name = "port"
    port = [22,25,80]
  }  
}