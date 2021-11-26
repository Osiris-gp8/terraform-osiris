# WEB_SERVER
resource "aws_instance" "web_server" {
    ami                 = var.amiHASH
    key_name            = var.keyName
    instance_type       = var.instanceTypeMicro
    subnet_id           = aws_subnet.public_subnet_osiris.id
    vpc_security_group_ids = [
        aws_security_group.http-https.id,
        aws_security_group.ssh.id,
        aws_default_security_group.default.id
    ]

    user_data           = file("configuracoes/configure.sh")

    tags = {
        Name            = "web-server"
    }
}

resource "aws_eip" "web_server" {
    instance              = aws_instance.web_server.id
    vpc                   = true

    tags = {
        Name                = "web-server"
    }
}

# BACK_SERVER
resource "aws_instance" "back_server" {
    ami                 = var.amiHASH
    instance_type       = var.instanceTypeSmall
    key_name            = var.keyName
    subnet_id           = aws_subnet.private_subnet_osiris.id
    vpc_security_group_ids = [
        aws_security_group.http-https.id,
        aws_security_group.ssh.id,
        aws_default_security_group.default.id
    ]

    user_data           = file("configuracoes/configure.sh")

    tags = {
        Name            = "back-server"
    }
}

resource "aws_eip" "back_server" {
    instance            = aws_instance.back_server.id
    vpc                 = true

    tags = {
        Name            = "back-server"
    }
}

# DATABASE
resource "aws_instance" "database" {
    ami                 = var.amiHASH
    instance_type       = var.instanceTypeMicro
    key_name            = var.keyName
    subnet_id           = aws_subnet.private_subnet_osiris.id
    vpc_security_group_ids = [
        aws_security_group.database.id,
        aws_security_group.ssh.id,
        aws_default_security_group.default.id
    ]

    user_data           = file("configuracoes/configure-database.sh")

    tags = {
        Name            = "database"
    }
}

resource "aws_eip" "database" {
    instance            = aws_instance.database.id
    vpc                 = true

    tags = {
        Name            = "database"
    }
}