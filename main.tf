terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36"
    }
  }
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "C:\\Users\\andre\\.aws\\credentials"
}

resource "aws_security_group" "allow_ping" {
  name        = "allow_ping"
  description = "Allow ICMP traffic"

  ingress {
    from_port   = 8 # ICMP type for Echo Request
    to_port     = 0 # ICMP code, 0 for Echo Request
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH rule
  ingress {
    from_port   = 22 # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example1" {
  ami             = "ami-053b0d53c279acc90" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type.
  instance_type   = "t2.micro"             # Free-tier eligible instance type
  key_name        = "andrew-keypair"
  security_groups = [aws_security_group.allow_ping.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install net-tools -y
              ifconfig > /home/ubuntu/ifconfig.txt
              EOF
}

resource "aws_instance" "example2" {
  ami             = "ami-053b0d53c279acc90" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type.
  instance_type   = "t2.micro"             # Free-tier eligible instance type
  key_name        = "andrew-keypair"
  security_groups = [aws_security_group.allow_ping.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install net-tools -y
              ifconfig > /home/ubuntu/ifconfig.txt
              EOF
}

output "public_ip1" {
  value = aws_instance.example1.public_ip
}

output "public_ip2" {
  value = aws_instance.example2.public_ip
}
