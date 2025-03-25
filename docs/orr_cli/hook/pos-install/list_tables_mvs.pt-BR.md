# Lista de tabelas e Materialized Views

## Tabelas presentes em todos os esquemas

Cada instituição vai ter a seguinte lista de tabelas
- **features**: Tabela que armazena todas as áreas de restauração do esquema. **Esta tabela só apresentará as áreas que forem inseridas pelo usuário do esquema correspondente.** Ex. Usuário do Pacto do Pantanal (pactopant_user) só irá inserir e ver as áreas de restauração compiladas pelo coletivo Pacto do Pantanal;

- **status_features**: Tabela que armazena o uuid de todas as áreas de restauração que estão fora do esquema do Pacto do Pantanal (pactopant), mas que estão dentro do bioma Pantanal, as registrando com um status 'PENDING' avaliação. É desta tabela que o usuário do Pacto do Pantanal poderá fazer checagens e definir se quer que estas áreas sejam incorporadas ao seu coletivo e apareçam futuramente em seu site de informações geográficas. O controle é feito ao escolher entre 'APPROVED' e 'REJECTED';

- **features_estra_rest**: prevista para armazenar a lista de respostas referentes à estratégias de restauração para cada linha de feature inserida em **features**.

- **features_met_comb**: prevista para armazenar a lista de respostas referentes à métodos secundários/combinados para cada linha de feature inserida em **features**.


## Materialized Views presentes em todos os esquemas

- **mv_features**: Esta MV sintetiza todas as áreas de restauração que estão com status 'APPROVED'. Demonstra tanto as áreas de restauração nativas do esquema, como a dos outros parceiros que estão localizadas dentro da área de interesse do esquema  Ex. Pacto do Pantanal  irá ter todas as áreas de restauração aprovadas, tanto as inseridas pelo pactopant_user quanto as que foram inseridas em outros esquemas, mas estão consideradas dentro do bioma Pantanal;

- **mv_notificacao_area**: Esta MV notifica ao usuário do esquema as áreas de restauração que são muito grandes (>200 ha) para que o usuário possa validar se é uma geometria que cumpre os requisitos de restauração.

- **mv_intersec_intern**: Esta MV notifica ao usuário do esquema as áreas de restauração (APENAS DA TABELA FEATURES) que apresentam possíveis erros topológicos (interseção, contém, toca).

- **mv_notificacao_formato**: Esta MV notifica quando ocorrem formatos de triângulo ou círculo (APENAS DA TABELA FEATURES) parq que o usuário possa conferir.

## Materialized view apenas no esquema ORR

- **mv_intersec_all**: Esta MV vai mostrar as interseções de polígonos entre diferentes redes biomáticas. É exclusiva para o Observatório, pois entende-se que ele poderá gerenciar e conferir com cada rede/instituição o que ocorreu e qual a melhor tratativa. Assim como a mv_intersec_inters mostra interseção, contem, está dentro, toca. Ex. Rede Sul inseriu um polígono que está interseccionando um polígono com o Pacto do Pantanal. O usuário do ORR poderá conversar com ambas as redes e decidir o que deve ser feito.