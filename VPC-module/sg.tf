# Security Groups
# Security Group for Bastion
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id
  description = "Allow only SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

# RDS Security Group
resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS"

  vpc_id = aws_vpc.vprofile_vpc.id

  # Allow incoming traffic from Elastic Beanstalk Security Group on RDS-specific ports (e.g., MySQL)
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.elastic_beanstalk_sg.id]
  }

  # Allow necessary outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "rds_security_group"
  }
}

# Elastic Beanstalk Security Group
resource "aws_security_group" "elastic_beanstalk_sg" {
  name        = "elastic-beanstalk-security-group"
  description = "Security group for Elastic Beanstalk"

  vpc_id = aws_vpc.vprofile_vpc.id

  # Allow incoming traffic on ports required by your application
  # Update the following rules based on your application's requirements
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow necessary outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elastic_beanstalk_sg"
  }
}
