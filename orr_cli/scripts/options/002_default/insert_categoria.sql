--INSERT INTO options.categoria (name_key, code_key, pt, en) 
--VALUES ('cat_reforestation','cat01', 'Reflorestamento', 'Reforestation');

INSERT INTO options.categoria (name_key, code_key, pt, en) 
VALUES ('cat_restoration','cat02', 'Restauração', 'Restoration');

INSERT INTO options.categoria (name_key, code_key, pt, en) 
VALUES ('cat_veg_sec','cat03', 'Vegetação Secundária', 'Secondary Vegetation');

INSERT INTO options.categoria (name_key, code_key, pt, en, text_replace) 
VALUES ('not_ident','cat00', 'Não identificado', 'Not identified', ARRAY['0']);