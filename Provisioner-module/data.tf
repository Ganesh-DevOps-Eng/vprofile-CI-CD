
data "aws_instance" "ec2" {
  filter {
    name   = "tag:Name"
    values = ["vprofile-eb-env"]
  }
}

output "ec2_hostname" {
  value = data.aws_instance.ec2.public_dns
}

# element(data.aws_instances.example.instances[*].public_dns, 0)

############ fetch endpoint 

data "aws_db_instance" "vprofile_rds" {
  db_instance_identifier = "vprofile-rds"
}

output "db_endpoint" {
  value = data.aws_db_instance.vprofile_rds.endpoint
}

#key
data "aws_key_pair" "my_key_pair" {
  filter {
    name = "tag:Name"
    values = ["my_key_pair"]
  }
}