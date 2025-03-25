


# Documentação das definições dos atributos desenvolvidas para o BD

## *Siglas das Instituições:*
- *ORR* - Observatório da Restauração e Reflorestamento  
- *PACTO* - Pacto pela Restauração da Mata Atlântica 

## *Definições dos atributos das tabelas:*
 As descrições dos atributos de cada tabela abaixo especificadas foram elaboradas de igual acordo com as equipes do PACTO e do ORR.

**Coluna**: IDNum.  
**Definição**: Número sequencial e único para cada polígono cadastrado.   
**Regras**: O número será único para cada polígono inseridos, não se repetirá e, mesmo que um determinado poligono seja removido, o número gerado não utilizado para outro. Este campo não será preenchido pelo usuário.   
**Restrição**: É preferível que o PACTO e o ORR adotem esta coluna.

**Coluna**: Fonte.   
**Definição**: Fonte dos dados (Ex: ORR, instituição, etc).    
**Regras**:Será preenchido pelo usuário ou compilador das informações para garantir que está registrando de onde o dado veio.    
**Restrição**: Deve ser de igual uso pelo PACTO e pelo ORR.    

**Coluna**: .   
**Definição**: Código de identificação do Polígono gerado pelo PACTO de forma sequencial com a codificação PMA (Ex: PMA001) e que poderá receber IDs de outras instituições, caso desejem fazer o mesmo.   
**Regras**: Preenchimento Pacto = ID sequencial a cada inserção de polígonos, ID não se repete, mesmo que o polígono seja removido. Não será preenchido pelo usuário.   
**Restrição**: Uso somente pelo PACTO, podendo ser utilizado por outras instituições futuramente.     

**Coluna**: polyid.   
**Definição**: Código de identificação dos Polígonos gerados após a separação de um multipolígono. Surgiu devido à necessidade de saber a localização correta das áreas de restauração, manter padrões e cálculos de área da melhor maneira possível.   
**Regras**: O banco a preencheu com um uuid para os casos em que a equipe GeoCode teve que separar multipolígonos. Quando surgirem novos casos, se a instituição reportadora não fizer o processo e reenviar o dado corretamente, o organizador do banco poderá fazer isso e guardar a iformação em polyid para que a instituição avalie dentro do banco se a separação está adequada para a mesma.   
**Restrição**: Deve ser de igual uso pelo PACTO e pelo ORR.    

**Coluna**: categoria.
**Definição**: Categoria de projeto/informação listada no ORR.
**Regras**: O preenchimento terá as seguintes categorias: Reflorestamento, Restauração, Vegetação Secundária e Não identificado. A opção de resposta inicialmente será apenas "Restauração". As demais categorias foram geradas para futuramente serem utilizadas.    
**Restrição**: Para o PACTO há uma tabela específica. PACTO e ORR não compartilham da mesma tabela categoria, mas ambas utilizam esse campo.

**Coluna**: fonte_schema.   
**Definição**: Nome da instituição que compilou os dados.    
**Regras**: A resposta será sempre automática, de acordo com o usuário que subir. A instituição que reporta e preenche a informação.     
**Restrição**: Não será preenchido pelo usuário.     

**Coluna**: projeto.    
**Definição**: Nome do projeto em que a área de restauração é vinculada.       
**Regras**: Preenchimento obrigatório de seleção única. Em caso de preenchimento em branco, será condicionada a resposta como “não identificado “. As opções de preenchimento são: sim, não, não se aplica e não identificado.    
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: nm_projeto.   
**Definição**: Nome do programa/projeto de restauração.    
**Regras**: Preenchimento optativo. A opção de preenchimento é Condicional:
Resposta SIM em "vinculo do projeto" é preenchido por texto livre / NÃO é preenchido como "não se aplica" / em branco preencher "não identificado").   
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: inst_exec.    
**Definição**: Nome da Instituição que executou a restauração.
**Regras**: Este campo não pode ter campo em branco, não se aplica e não identificado. A opção de preenchimento é de texto livre.     
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: inst_gest.   
**Definição**: Instituição que coordenou e contratou a executora da área de restauração.
**Regras**: A opção de preenchimento é de texto livre.    
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: inst_finan.   
**Definição**: Nome da Instituição origem dos recursos financeiros para a restauração.    
**Regras**: A opção de preenchimento é optativa e de texto livre. Caso fique sem preenchimento, será condicionado como “não identificado”.    
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: estra_rest.       
**Definição**: Estratégia de restauração.    
**Regras**: Esta coluna NÃO é visível para o usuário, ela é condicionada em relação a regra relacionada a coluna “MetPrinc”. Seu preenchimento será gerado conforme a regra de combinação entre as respostas da coluna “método principal” e “método secundário”.     
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: metod_princi.   
**Definição**: Principal método utilizado na restauração da área.    
**Regras**: Preenchimento obrigatório e de seleção única. Em caso de não preenchimento, será condicionada com a opção “não identificado”. As opções de preenchimento são: Isolamento, Controle das plantas competidoras, Adensamento, Enriquecimento, Nucleação, Semeadura direta, Plantio de mudas e Sistemas agroflorestais (SAFs) e Não se aplica.    
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: metod_comb.      
**Opção fixa**: É uma coluna condicionada pelas tabelas no schema options. 
**Definição**: Método auxiliar condicionado a escolha do método principal na restauração (MetPrinc).    
**Regras**: Métodos auxiliares condicionados em relação a escolha do método principal na restauração (MetPrinc). O preenchimento é optativo e de seleção múltipla. Em caso de não preenchimento, será condicionado a opção “não identificado”. As opções são: Isolamento, Controle das plantas competidoras, Adensamento, Enriquecimento, Nucleação, Semeadura direta, Plantio de mudas, Sistemas agroflorestais (SAFs) e Não se aplica.    
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: motivacao.    
**Definição**: Principal motivo para a restauração.     
**Regras**: Preenchimento obrigatório e de seleção única. Em caso de não preenchimento, será condicionado a resposta como não identificado. As opções de seleção são: adequação ambiental, biodiversidade, compensação ambiental no âmbito do licenciamento, compensação ambiental no âmbito do reparo de crime ambiental outros atos infracionais, projetos de carbono, projetos de PSA, outros fatores econômicos, recursos hídricos, outros objetivos, restauração voluntaria e não identificado.   
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: tipo_area.   
**Definição**: Local principal de execução da restauração.   
**Regras**: A opção de preenchimento é única e obrigatória, sendo escolhido uma das opções: Não identificado (quando não preenchido), Reserva Legal – RL, Area de excedente de Reserva Legal – ERL, Area de Preservação Permanente – APP, Area de reposição florestal obrigatória, Area de servidão florestal, Area de uso alternativo, Area de uso consolidado, Assentamentos rurais, Terras Indígenas, Terras Quilombolas, UC Reserva Biológica – REBIO, UC Parque Nacional – PARNA, UC Monumento Natural – MONA, UC Refugio de Vida Silvestre – RVS, UC Area de Proteção Ambiental – APA, UC Area de Relevante Interesse Ecológico – ARIE, UC Floresta Nacional – FLONA, UC Reserva Extrativista – RESEX, UC Reserva de Fauna – RF, UC Reserva de Desenvolvimento Sustentável – RDS, UC Reserva Particular do Patrimônio Natural – RPPN, outros.    
**Restrição**: É de igual uso pelo PACTO e pelo ORR.   

**Coluna**: uso_ant_ma.   
**Definição**: Uso e ocupação do solo anterior às atividades de restauração.    
**Regras**: Preenchimento optativo e de seleção única. Em caso de não preenchimento, será condicionado a opção de não identificado. A opções de preenchimento são:
Agricultura, floresta, pastagem, regeneração natural, silvicultura, solo exposto, outros e não identificado.   
**Restrição**: Uso restrito aos dados do PACTO.

**Coluna**: tipo_reflo.    
**Definição**: Tipo de reflorestamento/silvicultura.    
**Regras**: O preenchimento é de seleção única, sendo as opções: Plantio Consorciado de Espécies Nativas e Exóticas, Integração Lavoura-Pecurária-Floresta (ILPF), Monocultivo de Espécies Exóticas, Monocultivo de Espécies Nativas, Não identificado e Outros.     
**Restrição**: É de igual uso pelo PACTO e pelo ORR. Porém, não será preenchido pelo PACTO.    

**Coluna**: esp_reflo.   
**Definição**: Nome das espécies plantadas no reflorestamento/silvicultura.    
**Regras**: Preenchimento livre e não obrigatório.   
**Restrição**: É de igual uso pelo PACTO e pelo ORR. Porém, não será preenchido pelo PACTO.

**Coluna**: data_ini.    
**Definição**: Data que iniciou as atividades de restauração.     
**Regras**: Preenchimento obrigatório. A data deverá ser preenchida com dia, mês e ano (dd/mm/aaaa). Futuramente no frontend, quando o BD for implantado na plataforma/site, o planjamento é que a data seja apresentada somente no formato ano ou mês/ano.     
**Restrição**: É de igual uso pelo PACTO e pelo ORR.     

**Coluna**: proj_ativo.     
**Definição**: Informa se o projeto de restauração possui atividades em execução.      
**Regras**: O preenchimento é obrigatório e de seleção única. Caso não for preenchido, será condicionado ä resposta “Não identificado”. As opções de escolha são:  sim, não, não se aplica e não identificado.     
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: dat_concl.    
**Definição**: Data de encerramento das atividades de restauração.    
**Regras**: Preenchimento obrigatório e condicionado a coluna “ProjAtivo” seguindo a regra: Se na coluna “ProjAtivo” for atribuído SIM, então será preenchido com 0 (zero), caso a resposta for NÃO, então será preenchido a data.     
**Restrição**: É de igual uso pelo PACTO e pelo ORR. No entanto, para a ORR a data de conclusão será sem condicional.     

**Coluna**: ano_prev_t.    
**Definição**: Ano previsto para conclusão/termino do projeto de restauração.     
**Regras**: Preenchimento obrigatório e condicional, sendo: em caso de não preenchimento continuará vazio; em caso de resposta SIM em "projeto ativo" o ano será preenchido, em caso de resposta NÃO permanecerá vazio.     
**Restrição**: Uso apenas pelo PACTO.     

**Coluna**: link.    
**Definição**: Link para acesso e/ou sobre a informações do projeto.    
**Regras**: Campo facultativo e de texto livre.     
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    


**Coluna**: area_decl.    
**Definição**: Área em hectares declarada.     
**Regras**: As instituições podem enviar a área calculada em hectares em qualquer projeção, mas preferencialmente seguindo a 102023, de acordo com recomendação de responsáveis do WRI.    
**Restrição**: É de igual uso pelo PACTO e pelo ORR. 

**Coluna**: areacalc.    
**Definição**: Área em hectares calculada automaticamente pelo banco de dados.     
**Regras**:Cálculo feito na projeção 102023 para todas as áreas de restauração. Esta projeção está sendo utilizada devido à recomendação de responsáveis do WRI.    
**Restrição**: É de igual uso pelo PACTO e pelo ORR.

**Coluna**: Monitora.     
**Definição**: Indica se a área possui monitoramento da restauração em campo ou remoto.
**Regras**: Preenchimento obrigatório, com as opções de: sim, não e não identificado (em caso de não preenchimento da informação).     
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: privac_area.    
**Definição**: Indica se a área poderá ser exibida em mapa de acesso público.     
**Regras**: Preenchimento obrigatório com as opções de: Público, Privado e não definido (em caso de não preenchimento da informação).      
**Restrição**: É de igual uso pelo PACTO e pelo ORR.    

**Coluna**: prot_monit.    
**Definição**: Descrição do tipo de protocolo de monitoramento é empregado para monitorar a área de restauração.      
**Regras**: Preenchimento obrigatório e condicionada a coluna "monitoramento". As opções para o preenchimento são: caso houve preenchimento de resposta SIM na coluna "monitoramento", o preenchimento neste campo será de texto livre; em caso de preenchimento de resposta NÃO na coluna "monitoramento", o preenchimento neste campo será "não se aplica"; e em caso de não preenchimento da informação, será atribuído como “não identificado”.     
**Restrição**: Uso apenas pelo PACTO.     

**Coluna**: freq_monit.   
**Definição**: Descreve a frequência em que é realizado o monitoramento em campo na área de restauração.    
**Regras**: Preenchimento obrigatório e condicionada a coluna "monitoramento". As opções para o preenchimento são: caso houve preenchimento de resposta 
SIM na coluna "monitoramento", o preenchimento neste campo será de texto livre; em caso de preenchimento de resposta NÃO na coluna "monitoramento", o preenchimento neste campo será "não se aplica"; e em caso de não preenchimento da informação, será atribuído como “não identificado”.    
**Restrição**: Uso apenas pelo PACTO.   

**Coluna**: ano_prev_t.   
**Definição**: Com quantos anos pretende-se parar de realizar o monitoramento.   
**Regras**: Preenchimento obrigatório e condicionada a coluna "monitoramento". As opções para o preenchimento são: caso houve preenchimento de resposta SIM na coluna "monitoramento", o preenchimento neste campo será de texto livre; em caso de preenchimento de resposta NÃO na coluna "monitoramento", o preenchimento neste campo será "não se aplica"; e em caso de não preenchimento da informação, será atribuído como “não identificado”.   
**Restrição**: Uso apenas pelo PACTO.   