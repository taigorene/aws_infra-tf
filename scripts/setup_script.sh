#!/bin/bash
echo "E ae amigos! Criado pelo Terraform na AWS!!" > index.html
nohup busybox httpd -f -p 80 &

# Para converter para base64
# openssl base64 -in scripts/setup_script.sh -out scripts/setup_script64.sh