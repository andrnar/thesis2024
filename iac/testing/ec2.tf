data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}

resource "aws_instance" "test_env_ec2" {
  ami                         = data.aws_ami.ubuntu_ami.id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.tf_key.key_name
  vpc_security_group_ids      = ["${aws_security_group.security.id}"]
  associate_public_ip_address = true

  subnet_id = aws_subnet.subnet.id
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags = {
    Name = "testing-ngnix-server"
  }
}

resource "aws_eip" "elastic_ip" {
  domain   = "vpc"
  instance = aws_instance.test_env_ec2.id
}