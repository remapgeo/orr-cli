# Registro da correspondência entre as colunas utilizadas nos arquivos espaciais e as colunas do Banco de Dados


| Coluna do banco| Coluna do vetor |  Template          | CLI permite subir em branco/faltando coluna | CLI consegue preencher <sup>1<sup> |
|:-------------: |:---------------: | :---------------: | :---------------: |        :---------------: | 
| categoria  | Categoria |        ORR e PACTO    |Não.   | Não. Usuário deve preencher|
| dat_inicio | DataInici |    ORR e PACTO  | Não <sup>3<sup>          | Não. Usuário deve preencher |
| dat_concl | DataConcl |   ORR e PACTO | Não <sup>3<sup>| Não. Usuário deve preencher |
| fonte<sup>2<sup>  | Fonte | ORR e PACTO | Não <sup>3<sup>| Não. Usuário deve preencher |
| inst_exec | InstExecu | ORR e PACTO | Não <sup>3<sup>| Não. Usuário deve preencher |
| inst_finan| InstFinan | ORR e PACTO |Sim | Não. Usuário deve preencher |
| inst_gest | InstGest| ORR e PACTO |Sim | Não. Usuário deve preencher |
| link  | Link  | ORR e PACTO |Sim | Não. Usuário deve preencher |
| id |   IDNum | ORR e PACTO |Sim | Sim. CLI cria ID |
|met_princ | MetPrinc   | ORR e PACTO | Não<sup>3<sup>  | Não. Usuário deve preencher|
|met_comb | MetComb   |  ORR e PACTO |Provisoriamente sim |Sim. 'Não identificado'|
|
|monitorada | Monitora   |  ORR e PACTO | Provisoriamente sim | Sim. 'Não identificado'|
|motivacao | Motivacao   | ORR e PACTO | Provisoriamente sim | Sim. 'Não identificado'|
|projeto | Projeto   | ORR e PACTO | Provisoriamente sim | Sim. 'Não identificado'|
|nm_projeto | NmProjeto   | ORR e PACTO | Provisoriamente sim | Não. Usuário deve preencher |
|proj_ativo | ProjAtivo   | ORR e PACTO | Provisoriamente sim | Sim. 'Não identificado'|
|tipo_area | TipoArea   | ORR e PACTO | Provisoriamente sim | Sim. 'Não identificado'|
|tipo_reflo | TipoReflo   | ORR | Provisoriamente sim | Sim. 'Não identificado'|
|esp_reflo | EspReflo   | ORR |Sim | Não. Usuário deve preencher |
|privac_area | Privacidad   | ORR e PACTO | Provisoriamente sim | Sim. 'Não definido'|
|area_decl | AreaHa   | ORR e PACTO | Sim | Não. O banco irá gerar a area_calc |
|ano_prev | AnoPrevist   | PACTO | Sim | Não. O Usuário deve preencher |
|ano_prev_t | AnoPrevTe   | PACTO | Sim | Não. O Usuário deve preencher |
|prot_monit | ProtMonit   | PACTO | Sim | Não. O Usuário deve preencher |
|freq_monit | FreqMonit   | PACTO | Sim | Não. O Usuário deve preencher |
|uso_ant | UsoAnt   | PACTO | Sim | Sim. 'Não identificado' |


<sup>1<sup> Em casos da não existência da coluna, o CLI consegue criá-la e preencher automaticamente com não identificado ou opção adequada para quando estiver em branco. Algumas colunas são totalmente obrigatórias de preencher, como categoria e método principal, nestas o CLI só vai devolver um erro avisando que o usuário tem de refazer.

<sup>2<sup> A fonte aqui deve ser assinalada pelo usuário de acordo com as regras decididas. No banco terá a coluna **fonte_schema** que vai garantir que sempre se tenha o rastreamento do coletivo que reporta, de acordo com o usuário utilizado para subir as informações. (Aliança da Amazônia, Araticum, Pacto da Mata Atlântica, Pacto do Pantanal, ReCaa, Rede Sul ou o ORR)

<sup>3<sup> 
Pode passar a aceitar provisoriamente e deixar como **Não identificado** ou **em branco**, mas o ideal é ter, ao menos, estas colunas registradas.


