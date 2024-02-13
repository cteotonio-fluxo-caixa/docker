#!/bin/bash

# Espera até que o serviço do Splunk esteja disponível
echo "Aguardando o Splunk iniciar..."
while ! nc -z localhost 8000; do
  sleep 1
done

# Executa o comando para criar um novo índice
echo "Criando um novo índice..."
/opt/splunk/bin/splunk login -auth admin:Cade@123
/opt/splunk/bin/splunk add index fluxo_caixa
