# Terraform para criação de Instancia na AWS

Esse repo contém o script [Terraform](https://www.terraform.io/) para criação de um servidor, firewall na [AWS](https://aws.amazon.com) e VPC.

Base usada para demonstrações e estudo.

## Notas
No repositório local, é preciso criar um arquivo com as variáveis que são sensíveis e tem que permanecer seguras. Exemplo:

Nome: `terraform.tfvars`.
```
aws_access_key = ""
aws_secret_key = ""
ssh_public_key = ""
```
> Incluir também outras variaveis que achar importante no arquivo acima.

## Como usar

Clone o repo:
```
# git clone https://github.com/taigorene/aws_infra-tf.git
```

Configure as variáveis como citado em [Notas](#notas), e então basta executar os comandos:
```
# terraform init

# terraform apply
```

## Maintainer
Mantido por [Taígo](https://github.com/taigorene).