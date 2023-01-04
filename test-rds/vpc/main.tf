# Define our VPC to be used by the application

resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name          = "vpc-idecide"
    Environnement = var.env
  }
}

# Define the public subnets : 2 public subnets one in AZ-a and one in AZ-b	

resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet_cidr_a
  availability_zone = var.aws_az_a

  tags = {
    Name          = "Public Subnet A"
    Environnement = var.env
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet_cidr_b
  availability_zone = var.aws_az_b

  tags = {
    Name          = "Public Subnet B"
    Environnement = var.env
  }
}


# Define the private subnets : 2 private subnets one in AZ-a and one in AZ-b

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet_cidr_a
  availability_zone = var.aws_az_a

  tags = {
    Name          = "Private subnet A"
    Environnement = var.env
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet_cidr_b
  availability_zone = var.aws_az_b

  tags = {
    Name          = "Private subnet B"
    Environnement = var.env
  }
}


# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name          = "VPC IGW"
    Environnement = var.env
  }
}

# Define the public route table
resource "aws_route_table" "web_public_rt" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  /*
  route {
    cidr_block = "10.70.0.0/16"
    vpc_peering_connection_id = "pcx-0913f4d1b0c6dd4e0"
  }

  route {
    cidr_block = "10.80.0.0/16"
    vpc_peering_connection_id = "pcx-0fa967b04bd794b9b"
  }
*/
  tags = {
    Name          = "Public Subnet RT"
    Environnement = var.env
  }
}

# Assign the route table to the public Subnet (public-subnet-a et public-subnet-b)
resource "aws_route_table_association" "web_public_rt_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.web_public_rt.id
}

resource "aws_route_table_association" "web_public_rt_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.web_public_rt.id
}

# Create  an EIP for the NATGateway
resource "aws_eip" "nat-gateway-api" {
  vpc                       = true
  associate_with_private_ip = "10.60.10.8"

  tags = {
    Name          = "EIP for NAT"
    Environnement = var.env
  }
}

# Create NAT for accessing to internet from the private subnet

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-gateway-api.id
  subnet_id     = aws_subnet.public_subnet_a.id
}

# Create the Private Route table

resource "aws_route_table" "app-private-rt" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name          = "Private Subnet RT"
    Environnement = var.env

  }
}
resource "aws_route_table_association" "app-private-rt-a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.app-private-rt.id
}

resource "aws_route_table_association" "app-private-rt-b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.app-private-rt.id
}

# Define the security group for appidedcide VM

resource "aws_security_group" "sg_appidecide" {
  name        = "sg_appidecide"
  vpc_id      = aws_vpc.default.id
  description = "Allow incoming HTTP connections & SSH access"

  dynamic "ingress" {
    for_each = var.rules
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
      description = ingress.value["description"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "sg appidecide"
    Environnement = var.env
  }
}

# Define the security group for the sqlclient VM

resource "aws_security_group" "sg_sqlclient" {
  name        = "sg_sqlclient"
  vpc_id      = aws_vpc.default.id
  description = "Allow traffic from admin desktop"

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "IP Publique idecide"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["81.64.248.131/32"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_appidecide.id]
    description     = "Port Access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "IP Publique idecide"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "sg sqlclient"
    Environnement = var.env
  }
}

resource "aws_security_group" "sg_db_idecide" {
  name        = "sg_db_idecide"
  vpc_id      = aws_vpc.default.id
  description = "Allow trafic from both sqlidecide and appidecide"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_sqlclient.id, aws_security_group.sg_appidecide.id]
    description     = "Port Access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "sg of Postgre Database "
    Environnement = var.env
  }
}