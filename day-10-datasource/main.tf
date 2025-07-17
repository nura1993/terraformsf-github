module "ec2_instance" {
  source = "./modules/ec2"

  vpc_name      = var.vpc_name
  subnet_name   = var.subnet_name
  ami           = var.ami
  instance_type = var.instance_type
}

