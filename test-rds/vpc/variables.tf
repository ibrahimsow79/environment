# Attention pour l'adressage IP, il fait éviter les collisions. 


# CIDR Block Notation for the VPC
variable "vpc_cidr" {
  description = "CIDR for the VPC"
}

# Definition of AZs
variable "aws_az_a" {
  description = "Availbaility Zone a"
}
variable "aws_az_b" {
  description = "Availbaility Zone b"
}

# Definition of Environnment
variable "env" {
  description = "environnement : prod, dev, int,rec"
}

# CIDR Block Notation of the Public Subnets
variable "public_subnet_cidr_a" {
  description = "CIDR for the public subnet"
}

variable "public_subnet_cidr_b" {
  description = "CIDR for the public subnet"
}

#CIDR Block Notation of the Private Subnets
variable "private_subnet_cidr_a" {
  description = "CIDR for the private subnet"
}

variable "private_subnet_cidr_b" {
  description = "CIDR for the public subnet"
}
variable "rules" {
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.70.0.0/16"]
      description = "VPC peering Client1"
    },
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.80.0.0/16"]
      description = "VPC peering Client2"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "IP Publique idecide"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "IP Publique idecide"
    },
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "PING"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["81.64.248.131/32"]
      description = "IP Publique ISOW"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["62.240.254.145/32"]
      description = "IP Publique Calaranet"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["62.240.254.33/32"]
      description = "IP Publique Calaranet"
    }
  ]
}