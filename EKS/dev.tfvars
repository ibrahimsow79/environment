# project
project        = "one-headless"
env            = "dev"
region         = "eu-west-1"
aws_account_id = "621721940443"

# networking
vpc_cidr = "10.205.128.0/19"
subnets = [{
  subnet_availability_zone = "eu-west-1a"
  subnet_cidr_block        = "10.205.128.0/23"
  subnet_name              = "publicsubnet"
  subnet_public_ip         = true
  },
  {
    subnet_availability_zone = "eu-west-1b"
    subnet_cidr_block        = "10.205.130.0/23"
    subnet_name              = "publicsubnet"
    subnet_public_ip         = true
  },
  {
    subnet_availability_zone = "eu-west-1c"
    subnet_cidr_block        = "10.205.132.0/23"
    subnet_name              = "publicsubnet"
    subnet_public_ip         = true
  },
  {
    subnet_availability_zone = "eu-west-1a"
    subnet_cidr_block        = "10.205.136.0/21"
    subnet_name              = "privatesubnet"
    subnet_public_ip         = false
  },
  {
    subnet_availability_zone = "eu-west-1b"
    subnet_cidr_block        = "10.205.144.0/21"
    subnet_name              = "privatesubnet"
    subnet_public_ip         = false
  },
  {
    subnet_availability_zone = "eu-west-1c"
    subnet_cidr_block        = "10.205.152.0/21"
    subnet_name              = "privatesubnet"
    subnet_public_ip         = false
  }
]
natgws = [{
  natgw_availability_zone = "eu-west-1a"
  natgw_name              = "nat-gateway"
  natgw_subnet_name       = "publicsubnet"
}]

# eks cluster
cluster_version           = "1.24"
cluster_ip_family         = "ipv4"
cluster_service_ipv4_cidr = null
create_kms_key            = true

# eks node groupe
min_size     = 1
max_size     = 6
desired_size = 3
labels       = {}

# launch template
create_launch_template     = true
use_custom_launch_template = true
image_id                   = "ami-0ae92cf6a0a5d24d0"
instance_type              = "t3.medium"
block_device_mappings = {
  device1 = {
    device_name = "/dev/sda2",
    ebs = {
      volume_size = 80,
      volume_type = "gp2"
    }
  }
}

#eks addon
eks_addons = ["vpc-cni", "kube-proxy", "coredns"]

