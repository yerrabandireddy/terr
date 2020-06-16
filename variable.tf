variable "aws_region" {
  description = "To use AWS region"
  default = "ap-south-1"
}

variable "no_of_instances" {
default = "3"
}

variable "ami" {
default = "ami-0447a12f28fddb066"
}

variable "instance_type" {
default = "t2.micro"
}


variable "key" {
description = "Server Key file name"
default = "key4"
}

variable "bootstrap_path" {
  description = "Script to install startup"
  default = "demo.sh"
}
