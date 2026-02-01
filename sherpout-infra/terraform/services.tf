resource "aws_instance" "sherpout_server" {
  ami           = "ami-0f27749973e2399b6"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.tst.id
  vpc_security_group_ids = [aws_security_group.sherpout_tst_public_http_traffic.id]
  root_block_device {
    delete_on_termination = true
    volume_size = 10
    volume_type = "gp3"
  }

  tags = var.tags
}