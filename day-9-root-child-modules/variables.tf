variable "ami" {
  type    = string
  default = "ami-0c55b159cbfafe1f0" # Example: Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "instance_name" {
  type    = string
  default = "MyEC2Instance"
}

