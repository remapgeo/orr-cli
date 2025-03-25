-- DONE: neessa coluna manter apenas nao definido para quando nao tiver infos sobre 
-- DONE retirar nao se aplica

--INSERT INTO options.privac_area (name_key, code_key, pt, en, text_replace) 
--VALUES ('private_not_applicable','pri00', 'Não se aplica', 'Not applicable', ARRAY['0']);
INSERT INTO options.privac_area (name_key, code_key, pt, en, text_replace) 
VALUES ('private_not_id','pri00', 'Não identificado', 'Not identified', 
ARRAY['Não se aplica', 'Not applicable', '0']);
INSERT INTO options.privac_area (name_key, code_key, pt, en, text_replace) 
VALUES ('private_pri','pri02', 'Privado', 'Private', ARRAY['sim']);
INSERT INTO options.privac_area (name_key, code_key, pt, en, text_replace) 
VALUES ('private_pub','pri03', 'Público', 'Public', ARRAY['nao', 'publica']);

INSERT INTO options.privac_area (name_key, code_key, pt, en) 
VALUES ('private_pub','pri04', 'Não Definido', 'Not Defined' )