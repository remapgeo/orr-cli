# Resumo dos usuários e permissões para cada categoria de cadastro

Atualmente existem sete (7) esquemas em que é possível inserir áreas de restauração. São seis (6) esquemas que correspondem aos biomas brasileiros + o esquema do ORR. Existem 2 sufixos previstos para os usuários: **_master** e **_user**. Futuramente será possível desenvolver mais categorias de usuários de acordo com as necessidades identificadas.

**É importante entender que a base de dados foi desenvolvida para garantir que qualquer unidade geográfica possa ser uma área de interesse de um grupo. Inicialmente, os utilizadores trabalharão apenas com a escala de biomas, mas podem flexibilizar ou adicionar novos esquemas/grupos que trabalhem com cidades, estados, bacias hidrográficas, etc.**

| Usuário| Esquema de sufixo |  Ações permitidas    |  Bioma |    
|:-------------: |:---------------: | :---------------: |  :---------------: |  
| orr_master  | **_master**         |  criar esquemas, usuários, mudar senhas; criar e alterar tabelas, funções e MVs de todos os esquemas do banco; select em todas as tabelas; permissão para chamar todas as funções | Todos os biomas |
| orr_user | **_user** | select em todas as tabelas do banco; permissão para alterar as tabelas features e status_features do schema 'orr'; permissão para chamar funções |Todos os biomas |
| aliancaamz_user | **_user** | select em todas as tabelas do banco; permissão para alterar as tabelas features e status_features do schema 'aliancaamz'; permissão para chamar funções | Amazônia |
|araticum_user | **_user** | select em todas as tabelas do banco; permissão para alterar as tabelas features e status_features do schema 'araticum'; permissão para chamar funções | Cerrado |
|pactoma_user | **_user** | select em todas as tabelas do banco; permissão para alterar as tabelas features e status_features do schema 'pactoma'; permissão para chamar funções | Mata Atlântica |
|pactopant_user | **_user** | select em todas as tabelas do banco; permissão para alterar as tabelas features e status_features do schema 'pactopant'; permissão para chamar funções | Pantanal |
|recaa_user | **_user** | select em todas as tabelas do banco; permissão para alterar as tabelas features e status_features do schema 'recaa'; permissão para chamar funções | Caatinga |
|redesul_user | **_user** | select em todas as tabelas do banco; permissão para alterar as tabelas features e status_features do schema 'redesul'; permissão para chamar funções | Pampa|
