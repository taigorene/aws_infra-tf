resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.ssh_key_name
  public_key = var.ssh_public_key
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ec2_instance" {

  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  availability_zone = var.aws_az1
  key_name          = aws_key_pair.ec2_key_pair.key_name

  network_interface {
    network_interface_id  = aws_network_interface.dev-server-nic.id
    device_index          = 0
    delete_on_termination = false
  }

  ## Como estamos usando network interface, essas configurações abaixo não são necessárias e devem ser adicionadas na configuração da Network interface.
  # subnet_id = aws_subnet.dev1-subnet.id
  # security_groups = [aws_security_group.allow-web-traffic.id]
  # associate_public_ip_address = true

  root_block_device {
    volume_size           = 10 #GiB
    volume_type           = "gp2"
    delete_on_termination = true
    tags = {
      Name      = "ACME-storage",
      Terraform = "true"
    }
  }

  tags = {
    Name      = "acme",
    Terraform = "true"
  }

}
