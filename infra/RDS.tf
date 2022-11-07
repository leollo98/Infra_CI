resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "root"
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = "root"
  skip_final_snapshot  = true
  publicly_accessible  = true
}
