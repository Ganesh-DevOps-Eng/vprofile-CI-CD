variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

#bastion
variable "instance_type" {
  default = "t2.micro"
}

variable "project_name" {
    default = "mylo"
}

variable "ami_id" {
    default = "ami-0f5ee92e2d63afc18"
}