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
  region = "sa-east-1"
}

# Busca a imagem oficial mais recente do Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # conta oficial da Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
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
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]

  # Envia o Cloud-Init para a VM
  user_data = file("${path.module}/user-data.yaml")

  tags = {
    Name = "cloudinit-vm"
  }
}