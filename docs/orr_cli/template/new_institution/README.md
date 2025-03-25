# **Documentação das Materialized Views do BD**


## *Materialized Views para controle de acesso ao BD:*.   
    
    
**Criação de Índices “uuid” e “code_key”:**
 - *Creat_features*: são criadas as identificações nas tabelas para otimizar consultas baseadas em colunas dos esquemas, como por exemplo, no “features_met_comb" e “status_features”.

**Propriedade e concessão de privilégios:**
- *Creat_status_feature*: define o proprietário e as concessões específicas para os usuários, armazenando essas informações em uma tabela.   
Três instruções ALTER TABLE são usadas para alterar o proprietário das tabelas “features", “features_met_comb" e “features_estra_rest" para "orr_master". Isso define o usuário "orr_master" como o proprietário dessas tabelas, garantindo controle e segurança sobre elas.    
E duas instruções GRANT são usadas para conceder todos os privilégios nas tabelas ao usuário "user", permitindo o controle total sobre essas tabelas, incluindo permissões para SELECT, INSERT, UPDATE e DELETE.   
Ao final, é gerado uma tabela "status_features" para armazenar essas informações. Esta tabela é projetada com uma chave primária composta e índices adicionais para otimizar consultas relacionadas a "uuid", "schema_name" e "status".   
     
        

## *Materialized Views para Notificações de Formato:*
**Neste conjunto de scripts, são criadas Materialized Views para identificar áreas de restauração com problemas de formato, como círculos, triângulos e linhas, áreas de tamanho duvidosos. Como também, para analisar a possibilidade de haver áreas inseridas que correspondem ao mesmo local, ou que estão sobrepostas afim de avaliá-las.:**
 - *ob_creat_mv_circle_trangle*: seleciona áreas que foram definidas como formatos problemáticos, como círculos, triângulos e linhas, e combina essas informações com o status correspondente de cada área.
 
 -  *ob_creat_mv_tamanho*:  identifica áreas com tamanhos anômalos, ou seja, áreas com menos de 0,001 ha ou mais de 200 ha, e as combina com seus respectivos status.
 
 - *ob_mv_features*: utiliza o esquema ob_get_features_by_schema para recuperar os recursos do esquema especificado. Ela armazena os resultados dessa consulta para acesso rápido e eficiente posteriormente.
 
 - *ob_ mv_intersec_intern*: identifica interseções entre áreas, calcula a área de sobreposição, a porcentagem de sobreposição em relação à área original e transformando-as para um sistema de coordenadas específico e convertendo a unidade para hectares, indica se as geometrias se intersectam ou apenas se tocam, se uma geometria está totalmente dentro da outra ou se uma cobre a outra.   
 