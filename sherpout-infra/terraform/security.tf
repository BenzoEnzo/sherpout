resource "aws_security_group" "sherpout_tst_public_http_traffic" {
  vpc_id = aws_vpc.tst.id

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.sherpout_tst_public_http_traffic.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.sherpout_tst_public_http_traffic.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.sherpout_tst_public_http_traffic.id
  cidr_ipv4         = var.my_ip
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}