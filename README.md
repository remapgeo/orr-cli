# ORR-CLI

# Requisitos
É necessário os seguintes pacotes para desenvolvimento:

- [GIT-LFS](https://git-lfs.com/) - Versionamento de arquivos grrandes (`orr_cli/data`)
- Poetry - Gerenciar os pacotes do projeto
- Versão do postgres: 16

# Criar nova versão do pacote
Sempre que uma nova versão precisar chegar ao usuário, é necessário aumentar a versão.

Para criar nova versão, siga as instruções descritas [neste artigo](https://python-poetry.org/docs/cli/#version).

Após alterar a versão, caso a versão ainda não exista na hora de mergear para a branch `production`, uma nova tag será gerada e uma nova release será criada.

# Instalando o pacote

Para instalar o pacote, acesse a release desejada (acesse a última release disponível [aqui](https://github.com/Geobyte-Consultoria/orr-cli/releases/latest/)), e copie a tag da release desejada. Exemplo:

```bash
pip install git+ssh://git@github.com:Geobyte-Consultoria/orr-cli.git#v0.1.21
poetry add git+ssh://git@github.com:Geobyte-Consultoria/orr-cli.git#v0.1.21
```

Para atualizar o pacote, basta realizar o mesmo processo novamente passando o a url da nova versão.
