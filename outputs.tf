output "web_server_ip" {
    value = aws_instance.web_server.public_ip
    description = "Ip público do web server"

    depends_on = [
        aws_eip.web_server
    ]
}

output "back_server_ip" {
    value = aws_instance.back_server.public_ip
    description = "Ip público do servidor do back-end"

    depends_on = [
        aws_eip.back_server
    ]
}

output "database_ip" {
    value = aws_instance.database.public_ip
    description = "Ip público do servidor do banco de dados"

    depends_on = [
        aws_eip.database
    ]
}