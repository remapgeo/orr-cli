
-- DONE retirar nao se aplica
--INSERT INTO options.projeto (name_key, code_key, pt, en, text_replace) 
--VALUES ('proj_not_applicable','pro00', 'Não se aplica', 'Not applicable', ARRAY['0']);
INSERT INTO options.projeto (name_key, code_key, pt, en, text_replace) 
VALUES ('proj_not_id','pro00', 'Não identificado', 'Not identified', 
ARRAY['0','Não se aplica', 'Not applicable']);
INSERT INTO options.projeto (name_key, code_key, pt, en) 
VALUES ('proj_yes','pro02', 'Sim', 'Yes');
INSERT INTO options.projeto (name_key, code_key, pt, en) 
VALUES ('proj_no','pro03', 'Não', 'No');
