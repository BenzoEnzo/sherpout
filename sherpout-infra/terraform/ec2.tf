resource "aws_instance" "sherpout_tst_ec2" {
  ami           = "04233b5aecce09244"
  instance_type = "t3.micro"
}