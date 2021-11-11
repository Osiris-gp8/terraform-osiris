resource "aws_instance" "web-server" {
    ami = var.amiHASH
    instance_type = var.instanceTypeMicro
    key_name = var.keyName
    associate_public_ip_address = "true"
    subnet_id = aws_subnet.public_subnet_teste.id

    tags = {
        Name = "web-server"
    }
}

resource "aws_instance" "web-server" {
    ami = var.amiHASH
    instance_type = var.instanceTypeMedium
    key_name = var.keyName
    associate_public_ip_address = "true"
    subnet_id = aws_subnet.public_subnet_teste.id

    tags = {
        Name = "web-server"
    }
}

resource "aws_instance" "web-server" {
    ami = var.amiHASH
    instance_type = var.instanceType
    key_name = var.keyName
    associate_public_ip_address = "true"
    subnet_id = aws_subnet.public_subnet_teste.id

    tags = {
        Name = "web-server"
    }
}
