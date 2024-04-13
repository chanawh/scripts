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

resource "aws_instance" "example" {
  ami           = "ami-053b0d53c279acc90" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type.
  instance_type = "t2.micro"             # Free-tier eligible instance type
  key_name      = "andrew-keypair"
}

output "public_ip" {
  value = aws_instance.example.public_ip
}
