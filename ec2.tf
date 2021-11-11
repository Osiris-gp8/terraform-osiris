resource "aws_instance" "web-server" {
    ami = var.amiHASH
    instance_type = var.instanceTypeMicro
    key_name = var.keyName
    # associate_public_ip_address = "true"
    subnet_id = aws_subnet.public_subnet_teste.id
    vpc_security_group_ids = [
        aws_security_group.http-https.id,
        aws_security_group.ssh.id
    ]

    user_data = file("configure.sh")

    tags = {
        Name = "web-server"
    }
}

resource "aws_instance" "back-server" {
    ami = var.amiHASH
    instance_type = var.instanceTypeMedium
    key_name = var.keyName
    # associate_public_ip_address = "true"
    subnet_id = aws_subnet.private_subnet_teste.id
    vpc_security_group_ids = [
        aws_security_group.http-https.id,
        aws_security_group.ssh.id
    ]

    user_data = file("configure.sh")

    tags = {
        Name = "back-server"
    }
}

resource "aws_instance" "database" {
    ami = var.amiHASH
    instance_type = var.instanceTypeMicro
    key_name = var.keyName
    # associate_public_ip_address = "true"
    subnet_id = aws_subnet.private_subnet_teste.id
    vpc_security_group_ids = [
        aws_security_group.database.id,
        aws_security_group.ssh.id
    ]

    user_data = file("configure.sh")

    tags = {
        Name = "database"
    }
}

resource "aws_eip" "web-server" {
  instance = aws_instance.web-server.id
  vpc      = true
}

resource "aws_eip" "back-server" {
  instance = aws_instance.back-server.id
  vpc      = true
}

resource "aws_eip" "database" {
  instance = aws_instance.database.id
  vpc      = true
}