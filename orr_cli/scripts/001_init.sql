
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO orr_master;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO orr_master;

create schema orr_metadata;
alter schema orr_metadata owner to orr_master;

create table if not EXISTS orr_metadata.institutions (
	id serial4 NOT NULL,
	"name" varchar(50) NOT NULL,
	full_name varchar(256) NULL DEFAULT NULL::character varying,
	url varchar(256) NULL DEFAULT NULL::character varying,
	emails  varchar[] ,
	description text NULL,
	area_interest_country integer[] NULL,
	area_interest_cd_bioma integer[] NULL,
	area_interest_amz_legal bool NULL DEFAULT false,
	area_interest_matopiba bool NULL DEFAULT false,
	area_interest_cd_estado integer[] NULL,
	area_interest_cd_mun integer[] NULL,
	area_interest_geom public.geometry NULL DEFAULT NULL::geometry(MultiPolygon,4674),
	area_interest_cd_regiao integer[] NULL,
	area_interest_cd_macro_rh integer[] NULL,
	area_interest_cd_meso_rh integer[] NULL,
	area_interest_cd_micro_rh integer[] NULL,
	area_interest_amacro bool NULL DEFAULT false,
	template_sql VARCHAR(50) DEFAULT 'default',
	suffix VARCHAR(10) DEFAULT NULL::text,
	CONSTRAINT institutions_name_unique UNIQUE (name)
);
alter table orr_metadata.institutions 
        owner to orr_master;

CREATE INDEX institutions_name ON orr_metadata.institutions USING btree("name");
CREATE INDEX institutions_full_name ON orr_metadata.institutions USING btree("full_name");



INSERT INTO orr_metadata.institutions ("name",full_name,url,
emails,description,area_interest_country,area_interest_cd_bioma,area_interest_amz_legal,
area_interest_matopiba,area_interest_cd_estado,area_interest_cd_mun,area_interest_geom,
area_interest_cd_regiao,area_interest_cd_macro_rh,area_interest_cd_meso_rh,area_interest_cd_micro_rh,area_interest_amacro) VALUES
('orr','Observatório da Restauração e Reflorestamento','https://observatoriodarestauracao.org.br/',NULL,NULL,'{1}',NULL,false,false,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false);


 
