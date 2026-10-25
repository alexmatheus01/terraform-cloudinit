terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Define a região utilizada na AWS
provider "aws" {
  region = "us-east-2"
}

# Define regras para acessar a VM e cria o firewall
resource "aws_security_group" "web" {
  name        = "cloudinit-vm-sg"
  description = "Permite acesso HTTP ao Nginx"

  # Permite acesso ao servidor web Nginx
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permite tráfego de saída 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Configura a instância Linux necessária para a VM
resource "aws_instance" "vm_linux" {
  ami                    = "ami-020ba0ae8c230ae28"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]

  # Envia o Cloud-Init para a VM
  user_data = file("${path.module}/user-data.yaml")

  tags = {
    Name = "cloudinit-vm"
  }
}