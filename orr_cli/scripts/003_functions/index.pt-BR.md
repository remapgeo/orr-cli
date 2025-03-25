# Documentação das funções desenvolvidas para o BD

## *Funções com prefixo 'get' ou 'ob_get':*
Desenvolvidas para facilitar a análise geoespacial no contexto das regions ou polígonos, além das caracteríticas de uma determinada tabela. Elas 'pegam' as regiões às quais os polígonos pertencem extraindo informações específicas.*
 
 
 - *get_regions*: responsável por identificar as regiões mais comuns definidas pelo IBGE como municípios, estados, biomas etc;
 - *get_hidro*: responsável por identificar as macro, meso e microrregiões hidrográficas do Brasil;
 - *ob_get_interesection*: verifica a interseção entre duas geometrias (área de interesse e features) e retorna verdadeiro se a interseção exceder uma área mínima especificada ou uma porcentagem do polígono de features;
 - *ob_get_colides*: determina se duas geometrias têm uma colisão significativa com base em uma porcentagem mínima da interseção ou uma área mínima de interseção - serve para demonstrar ao analista/responsável que há geometrias com algum tipo de interferência;
 - *get_features_all_by_schema*: Retorna todas as linhas de uma determinada tabela de features, juntamente com seus metadados, com base no nome do esquema fornecido, utilizada para unir as áreas de restauração para o ORR e demais schemas que tenham como área de interesse o Brasil;
  - *ob_get_features_by_schema*: similar à função get_features_all_by_schema, mas retorna apenas as linhas de uma tabela de features com base no nome do esquema fornecido.
  

## *Função date_format:*
 A decisão de criar a função vem do fato dos parceiros não apresentarem um padrão de datas. Desta forma, a função normaliza as datas preenchendo as que não tem dia e/ou mês com o valor **01**. 
Graças ao registro da estrutura de data, as datas preenchidas ficam apenas para controle interno do banco. 

 - *date_format*: formata uma data de entrada em diferentes formatos de data com base em uma variedade de padrões, reconhecendo diferentes formatos de entrada.

**As Materialized Views de cada esquema, que são o produto final para aparecer nas plataformas, irão mostrar as informações encontradas em cada parceiro no formato de data padronizado com uma coluna indicando se o formato era completo, mês-ano ou só ano para que o frontend apresente da melhor forma.**

Abaixo um exemplo de parceiro que tinha apenas ANO, indicado pelo **y**.

![alt text](assets/image.png)

## *Funções com prefixo 'add':* Desenvolvidas para adicionar informações ao BD.


 - *ob_add_feature*: a função mais importante e que une diversas outras funções. Deve ser chamada utilizando call e passando parâmetros como: .
  Adiciona uma nova entidade com diversas propriedades (geométricas e de metadados) a uma tabela de features. Calcula e insere automaticamente as colunas associando a região e a hidrografia associadas à geometria. Além disso, a função insere o status da nova linha como **PENDING** para que seja avaliada pelas outras instituições. Ex. BlackJarguar insere uma área que cai no Cerrado e automaticamente vai chegar para a Araticum avaliar se aceita a área.
 - *ob_add_feature_ma*: semelhante à função ob_add_feature, mas com colunas adicionais específicas para o Pacto da Mata Atlântica. Todos os processos previstos em ob_add_features são repetidos no ob_add_features_ma. Deve ser chamada utilizando call e pasasndo parâmetros como:

## *Demais funções:*
 
 - *verificar_codigo_interesse_interno*: verifica se um número está presente em uma matriz de números passada como parâmetro;
 - *ob_verificar_codigo_interesse*: verifica se uma geometria está contida em uma área de interesse especificada por um esquema (instituição/rede parceira), utilizando uma série de condições e chamando a função verificar_codigo_interesse_interno;
 - *ob_insert_status*: insere ou atualiza o status de uma determinada linha (identificada por um UUID) em uma tabela de status. O status pode ser 'PENDING' 'APPROVED' ou 'REJECTED';
 - *is_circle*: calcula um valor entre 0 e 1 para indicar o quão próximo uma geometria está de ser um círculo perfeito. Elaborada para identificar geometrias que foram geradas através de pontos, por exemplo, com um buffer, podendo ser uma geometria de área não precisa;
 - *is_triangle*: verifica se uma geometria é um triângulo, verificando se ela consiste exatamente em três pontos;
 - *permission*: garante que os devidos privilégios serão aplicados para cada usuário/schema;
 - *refresh_materialized_views*: vai dar refresh em todas as MVs de interesse para as instituições/redes biomáticas - notificação de formato, notificação de áreas muito pequenas/muito grandes, notificação de interseções/possíveis erros topológicos e sumário de todas as áreas de restauração com o status 'APPROVED'. 




# Bases de dados das tabelas regions

## Tabela regions
Tem como fonte o Laboratório de Processamento de Imagens e Geoprocessamento (LAPIG) que sumariza diversas regiões importantes para o Brasil, atualizada no ano de 2022. 

## Tabela hidro_regions 
Tem como fonte  a Agência Nacional de Águas e Saneamento Básico (ANA) que apresenta a Divisão Hidrográfica Nacional produzida em parceria com o Instituto Brasileiro de Geografia e Estatística (IBGE) e publicada em 2021.

O resumo das tabelas é apresentado na tabela a seguir.
| Região geográfica | Fonte            | Compilado pelo LAPIG |
|:-------------:    |:---------------: | :-------------: |
| Municípios        | IBGE (2022)      | sim             |
| Estados           | IBGE (2022)      | sim             |
| Região            | IBGE (2022)      | sim          |
| País              | IBGE (2022)      | sim          |
| Amazônia Legal    | IBGE (2022)      | sim          |
| MATOPIBA          | IBGE (2022)      | sim          |
| AMACRO          | IBGE (2022)      | sim          |
| Macrorregiões Hidrográficas          | ANA/IBGE (2021)      | não          |
| Mesorregiões Hidrográficas          | ANA/IBGE (2021)      | não          |
| Microrregiões  Hidrográficas          | ANA/IBGE (2021)      | não          |



  