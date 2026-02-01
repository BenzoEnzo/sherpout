resource "aws_security_group" "sherpout_tst_public_http_traffic" {
  name = "server-sg"
  vpc_id = aws_vpc.tst_vpc.id

  tags = var.tags
}

resource "aws_security_group" "postgres_sg" {
  name   = "postgres-sg"
  vpc_id = aws_vpc.tst_vpc.id

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "server_http" {
  security_group_id = aws_security_group.sherpout_tst_public_http_traffic.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "server_https" {
  security_group_id = aws_security_group.sherpout_tst_public_http_traffic.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "server_ssh" {
  security_group_id = aws_security_group.sherpout_tst_public_http_traffic.id
  cidr_ipv4         = var.my_ip
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_security_group_rule" "postgres_ingress" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.postgres_sg.id
  source_security_group_id = aws_security_group.sherpout_tst_public_http_traffic.id
}