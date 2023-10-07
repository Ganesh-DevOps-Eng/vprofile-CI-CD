data "aws_security_group" "elastic_beanstalk_sg" {
  filter {
    name   = "tag:Name"
    values = ["elastic_beanstalk_sg"]
  }
}

output "elastic_beanstalk_sg" {
  value = data.aws_security_group.elastic_beanstalk_sg.id
}


data "aws_subnet" "public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["Public_Subnet_1"]
  }
}
data "aws_subnet" "public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["Public_Subnet_2"]
  }
}
data "aws_subnet" "public_subnet_3" {
  filter {
    name   = "tag:Name"
    values = ["Public_Subnet_3"]
  }
}

output "public_subnet_1" {
  value = data.aws_subnet.public_subnet_1.id
}
output "public_subnet_2" {
  value = data.aws_subnet.public_subnet_2.id
}
output "public_subnet_3" {
  value = data.aws_subnet.public_subnet_3.id
}



################ ec2 AMI id

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

############ fetch vpc

data "aws_vpc" "vprofile_vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc"]
  }
}

output "vpc" {
  value = data.aws_vpc.vprofile_vpc.id
}

data "aws_key_pair" "my_key_pair" {
  filter {
    name = "tag:Name"
    values = ["my_key_pair"]
  }
}
