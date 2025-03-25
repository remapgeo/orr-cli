-- DONE: retirar nao se aplica de estrategia
--INSERT INTO options.estra_rest (name_key, code_key, pt, en, text_replace) 
--VALUES ('est_rest_not_applicable', 'ers00', 'Não se aplica', 'Not applicable', ARRAY['0']);

INSERT INTO options.estra_rest (name_key, code_key, pt, en, text_replace) 
VALUES ('est_rest_not_id', 'ers00', 'Não identificado', 'Not identified',
 ARRAY['0','Não se aplica', 'Not applicable']);

INSERT INTO options.estra_rest (name_key, code_key, pt, en) 
VALUES ('est_rest_mixed', 'ers02', 'Estratégia Mista', 'Mixed Strategy');

INSERT INTO options.estra_rest (name_key, code_key, pt, en) 
VALUES ('est_rest_full_area_plant', 'ers03', 'Plantio em Área Total', 'Full Area Planting');

INSERT INTO options.estra_rest (name_key, code_key, pt, en) 
VALUES ('est_rest_reg_nat_withmaneg', 'ers04', 'Regeneração Natural com Manejo', 'Natural Regeneration with Management');

INSERT INTO options.estra_rest (name_key, code_key, pt, en) 
VALUES ('est_rest_reg_nat_nomaneg', 'ers05', 'Regeneração Natural sem Manejo', 'Natural Regeneration without Management');

INSERT INTO options.estra_rest (name_key, code_key, pt, en) 
VALUES ('est_rest_saf', 'ers06', 'Sistemas Agroflorestais (SAFs)', 'Agroforestry Systems (SAFs)');