# VPC
resource "aws_vpc" "VPC_teste" {
    cidr_block           = var.vpcCIDRblock
    instance_tenancy     = var.instanceTenancy 
    enable_dns_support   = var.dnsSupport 
    enable_dns_hostnames = var.dnsHostNames

    tags = {
        Name = "VPC teste"
    }
} 

# Subnet
resource "aws_subnet" "public_subnet_teste" {
    vpc_id                  = aws_vpc.VPC_teste.id
    cidr_block              = var.publicsCIDRblock
    map_public_ip_on_launch = var.mapPublicIP 
    availability_zone       = var.availabilityZone

    tags = {
        Name = "public-subnet-teste"
    }
}
resource "aws_subnet" "private_subnet_teste" {
    vpc_id                  = aws_vpc.VPC_teste.id
    cidr_block              = var.privatesCIDRblock
    map_public_ip_on_launch = var.mapPublicIP 
    availability_zone       = var.availabilityZone

    tags = {
        Name = "private-subnet-teste"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "IGW_teste" {
    vpc_id = aws_vpc.VPC_teste.id
    tags = {
        Name = "Internet gateway teste"
    }
}

# Route Table
resource "aws_route_table" "Public_RT" {
    vpc_id = aws_vpc.VPC_teste.id
    tags = {
        Name = "Public Route table"
    }
}

# Rota para o Internet Gateway
resource "aws_route" "internet_access" {
    route_table_id         = aws_route_table.Public_RT.id
    destination_cidr_block = var.publicdestCIDRblock
    gateway_id             = aws_internet_gateway.IGW_teste.id
}

# Associação da Route Table à subnet pública
resource "aws_route_table_association" "Public_association" {
    subnet_id      = aws_subnet.public_subnet_teste.id
    route_table_id = aws_route_table.Public_RT.id
}

# Security Group
resource "aws_security_group" "ssh" {
    name = "ssh"
    description = "SSH"

    vpc_id = aws_vpc.VPC_teste.id

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

    vpc_id = aws_vpc.VPC_teste.id

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

    vpc_id = aws_vpc.VPC_teste.id

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