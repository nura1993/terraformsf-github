

# Fetch existing VPC by tag
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Fetch existing Subnet by tag
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# Launch EC2 in the existing subnet
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.selected.id
  

  tags = {
    Name = "MyAppServer"
  }
}

