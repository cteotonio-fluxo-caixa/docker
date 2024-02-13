#!/bin/bash

# Espera at� que o servi�o do Splunk esteja dispon�vel
echo "Aguardando o Splunk iniciar..."
while ! nc -z localhost 8000; do
  sleep 1
done

# Executa o comando para criar um novo �ndice
echo "Criando um novo �ndice..."
/opt/splunk/bin/splunk login -auth admin:Cade@123
/opt/splunk/bin/splunk add index fluxo_caixa
