provider "aws" {
  region = "us-east-1"
}

module "web_instance" {
  source        = "./modules/ec2_instance"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  private_key   = file(var.private_key_path)
}

