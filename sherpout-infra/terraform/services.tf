resource "aws_instance" "sherpout_server" {
  ami           = "ami-0f27749973e2399b6"
  instance_type = "t3.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.tst_public_subnet.id
  vpc_security_group_ids = [aws_security_group.sherpout_tst_public_http_traffic.id]
  root_block_device {
    delete_on_termination = true
    volume_size = 10
    volume_type = "gp3"
  }

  tags = var.tags
}

resource "aws_db_instance" "sherpout_postgres" {
  identifier = "sherpout-postgres"
  allocated_storage = 20
  engine = "postgres"
  instance_class = "db.t3.micro"
  db_name = "sherpout"
  username = "dev"
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.postgres_subnet.name
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  publicly_accessible = false
  skip_final_snapshot = true

  tags = merge(var.tags, {
    Name = "sherpout-postgres"
  })
}