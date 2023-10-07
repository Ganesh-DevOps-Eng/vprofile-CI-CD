

###### fetch aws_security_group.rds_security_group.id

data "aws_security_group" "rds_security_group" {
  filter {
    name   = "tag:Name"
    values = ["rds_security_group"]
  }
}

output "rds_security_group" {
  value = data.aws_security_group.rds_security_group.id
}


data "aws_db_subnet_group" "db_sg" {
  name = "cse-cr"
}