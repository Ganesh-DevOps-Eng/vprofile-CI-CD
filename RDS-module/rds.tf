# RDS Instance


resource "aws_db_instance" "vprofile_rds" {
  identifier             = "vprofile-rds"
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = "admin"
  password               = "matellioPassword123!"
  db_subnet_group_name   = data.aws_db_subnet_group.db_sg.name
  vpc_security_group_ids = [data.aws_security_group.rds_security_group.id]
  skip_final_snapshot    = true

  tags = {
    Name = "vprofile_rds"
  }
}
