provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source            = "./modules/ec2_instance"
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
  instance_name     = var.instance_name
}
 
