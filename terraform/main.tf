provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "deployer" {
  # if u dont have, run: ssh-keygen -t rsa -b 4096 -f ~/.ssh/deployer-key
  # then allow permission: chmod 400 ~/.ssh/deployer-key
  key_name   = "deployer-key"
  public_key = file("~/.ssh/deployer-key.pub")
}

resource "aws_security_group" "ssh" {
  # using default VPC
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP access"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # for testing
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count         = var.num_ec2
  ami           = var.ami_id
  instance_type = var.type_ec2
  key_name      = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "web-${count.index + 1}"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Hello from instance ${self.tags["Name"]}'"]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/deployer-key")
      host        = self.public_ip
      timeout     = "2m"
    }
  }
}
