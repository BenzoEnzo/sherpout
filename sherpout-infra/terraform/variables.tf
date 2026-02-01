variable "vpc_cidr_block" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Public subnet CIDRs"
  type        = string
  default     = "10.0.0.0/24"
}

variable "tags" {
  description = "common tags"
  type = map(string)
  default = {
    Project = "sherpout"
    Environment = "tst"
  }
}

variable "my_ip" {
  description = "Your public IP for ssh"
  type        = string
}

