resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.env}-${var.name}-db-subnet-group"
  subnet_ids = [var.private_subnet[0], var.private_subnet[1], var.private_subnet[2]]
  tags = {
    Name = "${var.env}-${var.name}-db-subnet-group"
  }
}

resource "aws_db_instance" "db_instance" {
  allocated_storage    = var.db_storage
  storage_type         = var.db_storage_type

  db_name              = var.db_name
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az             = false
  db_subnet_group_name        = aws_db_subnet_group.db_subnet_group.name
  backup_retention_period     = 1

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_security_group" "rds_sg" {
  name        = "allow_ec2sg"
  description = "Allow from ec2 instance security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "from ec2sg"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    description = "to ec2sg"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}-db-sg"
  }
}
