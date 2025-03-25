![logo do projeto](assets/logo.png){width="250" class="center"}
# Cli OBSERVATÓRIO DA RESTAURAÇÃO E REFLORESTAMENTO

Para configurar o ambiente deve definir as variáveis de configuração no arquivo **settings.toml**
```toml
DB_NAME = 'dbname'
DB_USER = 'user'
DB_PASSWORD = 'senha123'
DB_HOST = 'localhost'
DB_PORT = 3356
```

Também pode definir como variável de ambiente usando o prefix "ORR_"

```bash
export ORR_DB_NAME='dbname'
```

Para instalar em um novo banco de dados use o comando 
```bash
orr install
```