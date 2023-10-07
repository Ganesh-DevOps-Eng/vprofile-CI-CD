resource "aws_db_subnet_group" "db_sg" {
  name        = "cse-cr"
  description = "Private subnets for RDS instance"
  subnet_ids  = [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id, ]
  tags = {
    Name = "db_sg"
  }
}