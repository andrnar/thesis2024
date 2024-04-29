resource "aws_vpc" "testing" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "test_env_vpc"
  }
}

resource "aws_subnet" "subnet" {
  cidr_block        = cidrsubnet(aws_vpc.testing.cidr_block, 3, 1)
  vpc_id            = aws_vpc.testing.id
  availability_zone = var.availability_zone
}

resource "aws_internet_gateway" "test_env_gw" {
  vpc_id = aws_vpc.testing.id
}

resource "aws_security_group" "security" {
  name = "allow-connection"

  vpc_id = aws_vpc.testing.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "local_file" "tf_key" {
  content  = tls_private_key.rsa-4096-example.private_key_pem
  filename = "keys.pem"
}

resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf_key" {
  key_name   = "ubuntu-testing-ssh-key"
  public_key = tls_private_key.rsa-4096-example.public_key_openssh
}
