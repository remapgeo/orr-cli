# Documentação das funções desenvolvidas para o BD

## *Triggers:*
Os Triggers (ou gatilhos) são automaticamente disparados em resposta a determinados eventos, como a inserção, atualização ou exclusão de dados em uma tabela.
 
 - *ob_geometry_informations_trigger*: com a adição de uma nova geometria, é identificado a região com base no IBGE (município, estado ou bioma) e a região hidrográfica a que pertence, então, é calculado a sua área em hectares e essas informações são inseridas em uma nova linha na tabela "features”;
  
 - *ob_update_date_modification*: toda vez que uma linha na tabela "features" for atualizada, o campo updated_at será automaticamente atualizado com o timestamp atual. Isso é útil para rastrear quando uma linha foi modificada pela última vez.