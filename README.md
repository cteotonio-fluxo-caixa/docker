# Projeto Fluxo de Caixa - Docker
Repositório com arquivos docker-compose.yml e scripts de implantação para facilitar a implantação e execução do sistema em contêineres Docker.

>[!IMPORTANTE]
>Caso você ainda não tenha visitado a página inicial deste projeto, recomendo começar por ela, pois há informações importantes sobre o projeto e configurações de ambiente.
>[Pagina inicial](https://github.com/cteotonio-fluxo-caixa)

## Como rodar o projeto ✅
1) Em seu Terminal navegue até a pasta clonada deste repositório
2) Dentro da pasta src digit o seguinte comando

```
docker-compose up -d
```

## ⚠️ Problemas enfrentados

### Erro ao subir containers:
Ao digitar o comando docker-compose up -d recebo a mensagem de erro: services.splunk_server must be a mappin
* Como solucionar: Certifique-se que o Docker estaja em execução e tente novamente.

### Erro ao subir container do SQL SERVER:
Um dos problemas mais comuns é a memoria que esta imagem requer (2GB)
* Como solucionar: Ajuste as configurações de merória que o docker pode reservar do windows.
1) Encontre o arquivo **.wslconfig** normalmente localizado em **DiretórioRaiz:/Users/SeuUsuario**, no meu caso ficou assim **C:\Users\Cleber**
2) Abra o arquivo em seu editor de texto
3) Adicione ou altera a configuração memory para uma quantidade que seja suficiente para subir os containers
4) Segue abaixo um exemplo de como ficou meu arquivo **.wslconfig**

```
[wsl2]
memory=5GB # How much memory to assign to the WSL2 VM.
processors=5 # How many processors to assign to the WSL2 VM.
```

5) Salve as alterações e reinicie o Docker
