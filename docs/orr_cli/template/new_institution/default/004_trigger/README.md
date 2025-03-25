
# **Documentação das funções desenvolvidas para o BD**

## *Triggers:*
**Antes de inserir os dados de uma instituição no BD, os seguintes triggers são acionados para cada schema:**
 - *trigger_update_regiao*: chama a função "ob_geometry_informations_trigger" para realizar operações relacionadas à atualização das informações de geometria.
 - *trigger_ob_update_date_modification*: chama a função "ob_update_date_modification" para atualizar a data de modificação dos dados da instituição.
 - *is_unique*: verifica se os novos dados são únicos com base em critérios específicos, como coordenadas geográficas e datas de início. Se os novos dados violarem a restrição de unicidade, uma exceção é lançada, impedindo a inserção ou atualização.
 - *trigger_ob_is_unique*: este gatilho aciona a função "is_unique()" para garantir que os novos dados sejam únicos antes de serem inseridos ou atualizados.
 
**E após a inserção ou atualização dos dados da instituição, as seguintes funções são acionadas:**

 - *ob_update_status*: atualiza o status das entidades da instituição com base em sua localização geográfica e outras informações relevantes.
 - *trigger_ob_update_status*: este gatilho é acionado chamando a função "ob_update_status" para atualizar o status das entidades da instituição após a inserção ou atualização.
 