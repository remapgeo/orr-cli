-- DONE retirar nao se aplica
-- DONE Coluna Motivação: Substituir "Atos infracionais" por "Outros atos infracionais"
-- DONE No campo "Principal motivo para a Restauração" em resposta "Restauração voluntária" substituir para "Outras restaurações voluntárias"

--INSERT INTO options.motivacao (name_key, code_key, pt, en, text_replace) 
--VALUES ('motiv_not_applicable', 'mot00','Não se aplica', 'Not applicable', ARRAY['0']);

INSERT INTO options.motivacao (name_key, code_key, pt, en, text_replace) 
VALUES ('motiv_not_id', 'mot00','Não identificado', 'Not identified', 
ARRAY['Não se aplica', 'Not applicable','0']);

INSERT INTO options.motivacao (name_key, code_key, pt, en) 
VALUES ('motiv_obli_environ_adeq','mot02', 'Adequação ambiental', 'Environmental adequacy');

INSERT INTO options.motivacao (name_key, code_key, pt, en) 
VALUES ('motiv_biodiversity','mot03', 'Biodiversidade', 'Biodiversity');

INSERT INTO options.motivacao (name_key, code_key, pt, en, text_replace) 
VALUES ('motiv_comp_licensing','mot04', 'Compensação ambiental no ambito do licenciamento', 'Environmental compensation within the scope of licensing', 
array['area de compensacao ambiental no ambito do licenciamento']);

INSERT INTO options.motivacao (name_key, code_key, pt, en) 
VALUES ('motiv_comp_crime','mot05', 'Compensação ambiental no ambito do reparo de crime ambiental', 'Environmental compensation in the context of repairing environmental crimes');

INSERT INTO options.motivacao (name_key, code_key, pt, en,text_replace) 
VALUES ('motiv_obli_infraction', 'mot06','Outros atos infracionais', 'Other acts of infraction',ARRAY['outros atos infracionais', 'atos infracionais']);

INSERT INTO options.motivacao (name_key, code_key, pt, en) 
VALUES ('motiv_vol_other','mot07', 'Outros Objetivos', 'Other objectives');

INSERT INTO options.motivacao (name_key, code_key, pt, en) 
VALUES ('motiv_vol_carbon', 'mot08','Projetos de Carbono', 'Carbon projects');

INSERT INTO options.motivacao (name_key, code_key, pt, en) 
VALUES ('motiv_vol_psa', 'mot09','Projetos de PSA', 'PSA projects');

INSERT INTO options.motivacao (name_key, code_key, pt, en) 
VALUES ('motiv_Water_resources','mot10', 'Recursos hidricos', 'Water resources');

INSERT INTO options.motivacao (name_key, code_key, pt, en) 
VALUES ('motiv_econom_factors','mot11', 'Outros fatores econômicos', 'Other economic factors');

VALUES ('motiv_vol_restoration','mot12', 'Outras restaurações voluntárias', 'Other voluntary restoration',
ARRAY['restaurações voluntárias','restauracoes voluntarias', 'restauracao voluntaria']);