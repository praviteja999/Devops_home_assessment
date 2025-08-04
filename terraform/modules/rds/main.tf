
resource "aws_db_subnet_group" "default" {
  name       = "${var.env}-rds-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name        = "${var.env}-rds-subnet-group"
    Environment = var.env
  }
}

resource "aws_db_instance" "db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  name                 = "appdb"
  username             = var.db_user
  password             = var.db_pass
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = []
  tags = {
    Environment = var.env
  }
}
