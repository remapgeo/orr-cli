INSERT INTO orr_metadata.institutions ("name",full_name,url,
emails,description,area_interest_country,area_interest_cd_bioma,area_interest_amz_legal,
area_interest_matopiba,area_interest_cd_estado,area_interest_cd_mun,area_interest_geom,
area_interest_cd_regiao,area_interest_cd_macro_rh,area_interest_cd_meso_rh,area_interest_cd_micro_rh,area_interest_amacro,template_sql,suffix) VALUES
('araticum','Araticum','https://araticum.lapig.iesa.ufg.br/',NULL,NULL,NULL,'{3}',false,false,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false,'default',NULL),
('aliancaamz','Aliança Amazônia','',NULL,NULL,'{}','{1}',false,false,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false,'default',NULL),
('redesul','Rede Sul','',NULL,NULL,NULL,'{5}',false,false,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false,'default',NULL),
('recaa','Caatinga','',NULL,NULL,NULL,'{2}',false,false,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false,'default',NULL),
('pactopant','Pacto Pantanal','',NULL,NULL,NULL,'{6}',false,false,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false,'default',NULL);

INSERT INTO orr_metadata.institutions ("name",full_name,url,
emails,description,area_interest_country,area_interest_cd_bioma,area_interest_amz_legal,
area_interest_matopiba,area_interest_cd_estado,area_interest_cd_mun,area_interest_geom,
area_interest_cd_regiao,area_interest_cd_macro_rh,area_interest_cd_meso_rh,area_interest_cd_micro_rh,area_interest_amacro,template_sql,suffix) VALUES
('pactoma','Pacto da Mata Atlântica','https://www.pactomataatlantica.org.br/',NULL,NULL,NULL,'{4}',false,false,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false,'pactoma','ma');


ALTER DEFAULT PRIVILEGES IN SCHEMA options GRANT SELECT ON TABLES TO PUBLIC;

GRANT USAGE ON SCHEMA orr_metadata TO PUBLIC;
GRANT SELECT ON TABLE orr_metadata.institutions TO PUBLIC;

GRANT SELECT ON TABLE orr_metadata.hidro_regions TO PUBLIC;

GRANT SELECT ON TABLE orr_metadata.regions TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA orr_metadata GRANT SELECT ON TABLES TO PUBLIC;