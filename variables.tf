variable "cidr" {
  default = "10.0.0.0/16"
}

variable "cidr_sub" {
  default = "10.0.2.0/24"
}

variable "cidr_sub2" {
  default = "10.0.1.0/24"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}

variable "rt_route" {
  default = "0.0.0.0/0"
}


variable "ami_id" {
  default = "ami-04b4f1a9cf54c11d0"
}

variable "instance-type" {
  default = "t2.micro"
}


variable "loadbal-type" {
  default = "application"
}
