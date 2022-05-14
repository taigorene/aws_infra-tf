# Create VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name      = "development",
    Terraform = "true"
  }
}

# Create subnet(s)
# Subnets have to be allowed to automatically map public IP addresses for worker nodes
resource "aws_subnet" "dev1-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.aws_az1
  map_public_ip_on_launch = true

  tags = {
    Name      = "dev1-subnet",
    Terraform = "true"
  }
}

resource "aws_subnet" "dev2-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.aws_az2
  map_public_ip_on_launch = true

  tags = {
    Name      = "dev2-subnet",
    Terraform = "true"
  }
}

# Create a NIC(s)
resource "aws_network_interface" "dev-server-nic" {
  subnet_id       = aws_subnet.dev1-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow-web-traffic.id]
  tags = {
    Name      = "ServerNIC"
    Terraform = "true"
  }
}

# Create Elastic IP
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.dev-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.dev-gw]
  tags = {
    Name      = "ServerNIC"
    Terraform = "true"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name      = "dev-gw",
    Terraform = "true"
  }
}

# Create Route Table
resource "aws_route_table" "dev-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.dev-gw.id
  }


  tags = {
    Name      = "dev-rt",
    Terraform = "true"
  }
}

# Create Route Table Association for dev1-subnet to dev-rt
resource "aws_route_table_association" "dev1-sub-to-dev-rt" {
  subnet_id      = aws_subnet.dev1-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}

# Create Route Table Association for dev2-subnet to dev-rt
resource "aws_route_table_association" "dev2-sub-to-dev-rt" {
  subnet_id      = aws_subnet.dev2-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}
