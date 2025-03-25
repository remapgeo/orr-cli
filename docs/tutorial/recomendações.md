# Recomendações para iniciar o CLI - Treinamento 

## Criar arquivo settings.toml local
Você deve criar uma pasta no caminho de sua preferência e dentro dela criar o arquivo settings.toml. Você irá colar dentro dele as informações de conexão com o banco de dados. <sup>1

<sup>1 O texto com as informações será repassado no treinamento. Abaixo tem um exemplo da configuração necessária.

```bash
[default]
DB_NAME='db_name'
DB_USER='db_user'
DB_PASSWORD='****'
DB_HOST='localhost'
DB_PORT=5432
```

## Baixar e instalar o pacote ORR-CLI

Utilize o comando abaixo
```bash
pip install https://github.com/GeoCode-Labs/orr-cli/releases/download/v0.1.0/orr_cli-0.1.0-py3-none-any.whl 
```

## Criar um banco de dados
O comando abaixo serve para desenvolver as estruturas e funções necessárias para o funcionamento previsto para o banco de dados considerando que você está utilizando o orr_master.
*Este comando só precisa ser utilizado quando se quer criar um banco do zero. A partir do momento que o banco estiver funcionando não é obrigatório ficar criando novos.*
```bash
orr install init  
```

## Criar um usuário
Este comando vai criar os esquemas de redes biomáticas/instituições, usuário correspondente, tabelas, funções etc necessários.
```bash
orr institution new --name nomerede --password  senha@123 --template default
```
**--name** usado para o nome da rede biomática

**--password** a senha do usuário

**--template** nome da template para construir o schema

## Comandos reservados para os técnicos de cada rede biomática
Primeira função checa a validade de um arquivo vetorial (shapefile ou geopackage), isto é, se as colunas e a geometria estão de acordo com as regras de sua template
```bash
orr file check areas_restauracao.shp
```
Se não houver erros no arquivo, o comando gera um geopackage na mesma pasta do arquivo original com nome de **areas_restauracao_valid.gpkg** 

Caso encontre um erro no arquivo, o comando retorna um arquivo .txt detalhando os erros por linha e coluna para que o usuário possa corrigir.

Após a verificação, o usuário pode enviar o arquivo _valid.gpkg usando o comando
```bash
orr file push areas_restauracao_valid.gpkg
```

# Considerações finais

O Banco de Dados não trabalha com Multipolígonos, desse modo o CLI vai efetuar uma validação. Caso exista Multipolígono, ele irá dividí-lo em polígonos individuais gerando novas linhas com o mesmo polyid - coluna usada para poder verificar os casos de multipolígono separados. Por mais que a função seja eficiente, recomenda-se evitar o uso deste tipo de geometria para assegurar que não ocorrerão erros neste tipo de conversões.


