#creating vpc
resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "prod_vpc"
  }
}

#creating IG
resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "prod_IG"
  }
}

#creatiing public subnet
resource "aws_subnet" "prod" {
  vpc_id = aws_vpc.prod.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "prod_subnet"
  }
}

#create private subnet
resource "aws_subnet" "prvt_subnet" {
  vpc_id = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private_subnet"
  }
}



#creating  public_RT
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.prod.id
  
route {
    gateway_id = aws_internet_gateway.prod.id
    cidr_block = "0.0.0.0/0"
}
}


#subnet association for public_subnet
resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.name.id
  subnet_id = aws_subnet.prod.id
}

#creating elastic ip
resource "aws_eip" "prod_eip" {
  depends_on = [aws_internet_gateway.prod]
}

#creat Nat gateway
resource "aws_nat_gateway" "name" {
  subnet_id = aws_subnet.prod.id
  allocation_id = aws_eip.prod_eip.id
  depends_on = [aws_internet_gateway.prod]
}

#create prvt_rt
resource "aws_route_table" "prvt_rt" {
  vpc_id = aws_vpc.prod.id

  route {
    nat_gateway_id = aws_nat_gateway.name.id
    cidr_block = "0.0.0.0/0"
  }
}

#subnet association for Prvt_subnet
resource "aws_route_table_association" "prvt_subassoc" {
  route_table_id = aws_route_table.prvt_rt.id
  subnet_id = aws_subnet.prvt_subnet.id
}


#create sg group
resource "aws_security_group" "allow_tls" {
  name = "allow-tls"
  description = "allow TLS inbound traffic"
  vpc_id = aws_vpc.prod.id

ingress {
    description = "TLS from vpc"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

#creation of public ec2
resource "aws_instance" "prod" {
  ami = "ami-0a1235697f4afa8a4"
  instance_type = "t2.micro"
  key_name = "gangsterkey"
  subnet_id = aws_subnet.prod.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  tags = {
    Name = "prod_ec2"
  }
}

#creation of private ec2
resource "aws_instance" "prod_prvtec2" {
  ami = "ami-0a1235697f4afa8a4"
  instance_type = "t2.micro"
  key_name = "gangsterkey"
  subnet_id = aws_subnet.prvt_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "prod_prvt-ec2"
  }
}