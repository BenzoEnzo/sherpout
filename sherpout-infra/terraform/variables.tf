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

variable "private_subnet_cidr_block" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
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
  description = "public IP for ssh from private vars"
  type        = string
}

variable "db_password" {
  description = "database pass from private vars"
  type        = string
}

