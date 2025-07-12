resource "aws_instance" "my-ec2" {
  ami = "ami-0d03cb826412c6b0f"
  instance_type = "t2.micro"
  key_name = "gangsterkey"
}

