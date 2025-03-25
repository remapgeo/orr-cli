--INSERT INTO options.categoria_ma (name_key, code_key, pt, en) 
--VALUES ('cat_reforestation','cat0'3, 'Reflorestamento', 'Reforestation');

INSERT INTO options.categoria_ma (name_key, code_key, pt, en) 
VALUES ('cat_restoration','cat01', 'Restauração', 'Restoration');

INSERT INTO options.categoria_ma (name_key, code_key, pt, en) 
VALUES ('cat_veg_sec','cat02', 'Vegetação Secundária', 'Secondary Vegetation');

INSERT INTO options.categoria_ma (name_key, code_key, pt, en, text_replace) 
VALUES ('not_ident','cat00', 'Não identificado', 'Not identified', ARRAY['0']);
