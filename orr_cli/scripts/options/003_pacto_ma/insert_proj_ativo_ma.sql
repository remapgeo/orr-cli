-- DONE retirar nao se aplica 

--INSERT INTO options.proj_ativo_ma (name_key, code_key, pt, en, text_replace) 
--VALUES ('proj_active_not_applicable','pja00', 'Não se aplica', 'Not applicable', ARRAY['0']);
INSERT INTO options.proj_ativo_ma (name_key, code_key, pt, en, text_replace) 
VALUES ('proj_active_not_id','pja00', 'Não identificado', 'Not identified',
 ARRAY['0', 'Não se aplica', 'Not applicable']);
INSERT INTO options.proj_ativo_ma (name_key, code_key, pt, en) 
VALUES ('proj_active_yes','pja02', 'Sim', 'Yes');
INSERT INTO options.proj_ativo_ma (name_key, code_key, pt, en) 
VALUES ('proj_active_no','pja03', 'Não', 'No');
