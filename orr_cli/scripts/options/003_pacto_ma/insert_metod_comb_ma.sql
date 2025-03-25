-- TODO mrs03 e mrs08 devem virar mrs13
-- DONE retirar nao se aplica


--INSERT INTO options.met_comb_ma (name_key, code_key, pt, en, text_replace)
--VALUES ('met_rest_not_appli', 'mrs00','Não se aplica', 'Not applicable', ARRAY['0']);

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en, text_replace)
VALUES ('met_rest_not_id', 'mrs00', 'Não identificado', 'Not identified', ARRAY['0','Não se aplica', 'Not applicable']);

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_reg_densification', 'mrs02', 'Adensamento', 'Densification');

--INSERT INTO options.met_comb_ma (name_key, code_key, pt, en, text_replace)
--VALUES ('met_rest_fencing', 'mrs03', 'Cercamento', 'Fencing', ARRAY['cercamento/isolamento da área cercamento', 'cercamento/isolamento da área']);

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_reg_comp_control', 'mrs04', 'Controle das plantas competidoras', 'Control of competing plants');

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_reg_enrichment', 'mrs05', 'Enriquecimento', 'Enrichment');

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_reg_nucleation', 'mrs06', 'Nucleação', 'Nucleation');

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_full_seedling_plant', 'mrs07', 'Plantio de Mudas', 'Seedling planting');

--INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
--VALUES ('met_rest_reg_nat_nomaneg', 'mrs08', 'Regeneração natural sem manejo', 'Natural Regeneration without Management');

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_saf',  'mrs10','Sistemas Agroflorestais (SAFs)', 'Agroforestry Systems (SAFs)');

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_reg_nat_withmaneg',  'mrs11','Regeneração Natural com Manejo', 'Natural Regeneration with Management');

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_combined',  'mrs12','Métodos combinados de diferentes estratégias', 'Combined methods of different strategies');

INSERT INTO options.met_comb_ma (name_key, code_key, pt, en,text_replace)
VALUES ('met_rest_reg_nat_isolation',  'mrs13','Isolamento', 'Isolation', 
ARRAY['Cercamento', 'Fencing', 'cercamento/isolamento da área cercamento', 'cercamento/isolamento da área']);


INSERT INTO options.met_comb_ma (name_key, code_key, pt, en)
VALUES ('met_rest_dir_eeding', 'mrs14', 'Semeadura direta', 'Direct seeding');