resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name

  tags = {
    Name = "ModuleEC2"
  }
}

resource "null_resource" "install_nginx" {
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo 'NGINX installed successfully'"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = var.private_key
      host        = aws_instance.web.public_ip
    }
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [aws_instance.web]
}

