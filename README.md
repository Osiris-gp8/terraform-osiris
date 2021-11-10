# terraform-osiris
Repositório de fonte do script em Terraform para automatização da criação da infraestrutura na AWS

## __Configurações necessárias__

Antes de começar executar o terraform é necessário colocar as credenciais da aws na máquina. Também é necessário ter o AWS CLI instalado, assim como o terraform.

As credenciais se encontra na tela do vocareum. Ao clicar no botão "Account Details", vai abrir uma caixa mostrando as credenciais do AWS CLI.

Ao copiar as credenciais, crie o arquivo "credencials" no diretório ~/.aws, resultando assim:

- ~/.aws/credentials

## __Comandos necessários para execução dos scripts__

### terraform init

O terraform init faz o download dos provedores e suas versões, configurados no arquivo main.tf, e prepara o diretório para o uso do terraform

### terraform plan

O terraform plan cria um plano de execução, que consiste em: 
- Ler o estado atual de qualquer objeto remoto já existente para garantir que o estado do Terraform esteja atualizado.
- Comparando a configuração atual com o estado anterior e observando quaisquer diferenças.
- Propor um conjunto de ações de mudança que devem, se aplicadas, fazer com que os objetos remotos correspondam à configuração.

### terraform apply

Aplica o plano de execução