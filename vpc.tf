# VPC
resource "aws_vpc" "vpc_osiris" {
    cidr_block           = var.vpcCIDRblock
    instance_tenancy     = var.instanceTenancy 
    enable_dns_support   = var.dnsSupport 
    enable_dns_hostnames = var.dnsHostNames

    tags = {
        Name = "vpc-osiris"
    }
} 

# Subnet
resource "aws_subnet" "public_subnet_osiris" {
    vpc_id                  = aws_vpc.vpc_osiris.id
    cidr_block              = var.publicsCIDRblock
    map_public_ip_on_launch = var.mapPublicIP 
    availability_zone       = var.availabilityZone

    tags = {
        Name = "public-subnet-osiris"
    }
}

resource "aws_subnet" "private_subnet_osiris" {
    vpc_id                  = aws_vpc.vpc_osiris.id
    cidr_block              = var.privatesCIDRblock
    map_public_ip_on_launch = var.mapPublicIP 
    availability_zone       = var.availabilityZone

    tags = {
        Name = "private-subnet-osiris"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "igw_osiris" {
    vpc_id = aws_vpc.vpc_osiris.id
    tags = {
        Name = "internet-gateway-osiris"
    }
}

# Route Table
resource "aws_route_table" "rtb_osiris" {
    vpc_id = aws_vpc.vpc_osiris.id
    tags = {
        Name = "route-table-osiris"
    }
}

# Rota para o Internet Gateway
resource "aws_route" "internet_access" {
    route_table_id         = aws_route_table.rtb_osiris.id
    destination_cidr_block = var.publicdestCIDRblock
    gateway_id             = aws_internet_gateway.igw_osiris.id
}

# Associação da Route Table à subnet pública
resource "aws_route_table_association" "public_association" {
    subnet_id      = aws_subnet.public_subnet_osiris.id
    route_table_id = aws_route_table.rtb_osiris.id
}

# Security Group
resource "aws_security_group" "ssh" {
    name = "ssh"
    description = "SSH"

    vpc_id = aws_vpc.vpc_osiris.id

    ingress = [
        {
            description = "ssh"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        }
    ]

    tags = {
        Name = "ssh"
    }
}

resource "aws_security_group" "http-https" {
    name = "http-https"
    description = "aplicacao"

    vpc_id = aws_vpc.vpc_osiris.id

    ingress = [
        {
            description = "http"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        },
        {
            description = "https"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        }
    ]
    
    tags = {
        Name = "http-https"
    }
}

resource "aws_security_group" "database" {
    name = "database"
    description = "banco"

    vpc_id = aws_vpc.vpc_osiris.id

    ingress = [
        {
            description = "banco"
            from_port = 3306
            to_port = 3306
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        }
    ]

    tags = {
        Name = "database"
    }
}