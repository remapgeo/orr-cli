/* DONE: remover o multipolygon
   DONE: verificar todos as colunas se estão ok
   DONE remover as colunas de reflorestamento no constrint unique
   DONE adicionar todas as colunas de options na constraint
   DONE indexes
   DONE adicionar nao identificado como default para todas as cols
*/
CREATE TABLE IF NOT EXISTS "{{schema}}".features(
        uuid   uuid   default  uuid_generate_v4() not null constraint {{schema}}_features_pk primary key,
        geom geometry(Polygon, 4674),
        polyid VARCHAR(255) DEFAULT uuid_generate_v4(),
        id           numeric(6),
        categoria    varchar(5) default 'cat00',
        projeto    varchar(5) default 'pro00',
        nm_projeto    varchar(250) default 'Não identificado',
        inst_exec varchar(250) default 'Não identificado',
        inst_gest varchar(250) default 'Não identificado',
        inst_finan    varchar(250) default 'Não identificado',
        met_princ varchar(5) default 'mrs00',
        motivacao   varchar(5) default 'mot00',
        tipo_area    varchar(5) default 'tip00',
        dat_inicio   ob_date,
        proj_ativo   varchar(5) default 'pja00',
        dat_concl      ob_date,
        area_decl    double precision,
        monitorada   varchar(5) default 'mon00',
        fonte        varchar(100)    default '{{schema}}'::character varying,
        link         varchar(250) default 'Não identificado',
        privac_area   varchar(5) default 'pri04',

        area_ha_calc   double precision,
        regiao_objectid integer,
        cd_country  integer,
        cd_regiao integer ,
	    cd_bioma integer ,
	    amaz_legal boolean ,
	    matopiba boolean ,
	    amacro boolean ,
	    cd_geouf integer ,
	    cd_geocmu integer ,
        hidro_objectid integer,
	    cd_macro_rh int ,
	    cd_meso_rh int ,
	    cd_micro_rh int ,
        data_version int default 1,
        geohash varchar(16),


        fonte_schema varchar(100)    default '{{schema}}'::character varying,
        created_at   timestamp with time zone default now() not null,
        updated_at   timestamp with time zone default now() not null,

        FOREIGN KEY (categoria) REFERENCES options.categoria(code_key),
        FOREIGN KEY (motivacao) REFERENCES options.motivacao(code_key),
        FOREIGN KEY (proj_ativo) REFERENCES options.proj_ativo(code_key),
        FOREIGN KEY (projeto) REFERENCES options.projeto(code_key),
        FOREIGN KEY (met_princ) REFERENCES options.met_princ(code_key),
        FOREIGN KEY (monitorada) REFERENCES options.monitorada(code_key),
        FOREIGN KEY (tipo_area) REFERENCES options.tipo_area(code_key),
        FOREIGN KEY (privac_area) REFERENCES options.privac_area(code_key),
        FOREIGN KEY (fonte_schema) REFERENCES orr_metadata.institutions(name),
        CONSTRAINT unique_{{schema}}_geohash_dat_inicio UNIQUE (geohash,
            dat_inicio, 
            met_princ,
            inst_exec,
            inst_gest, 
            inst_finan,
            categoria,
            motivacao,
            proj_ativo,
            projeto,
            monitorada,
            tipo_area,
            data_version )
    );

create index IF NOT EXISTS {{schema}}_features_wkb_geometry_geom_idx
    on "{{schema}}".features using gist (geom); 


CREATE INDEX {{schema}}_features_uuid_idx ON {{schema}}.features USING btree (uuid);
CREATE INDEX {{schema}}_features_polyid_idx ON {{schema}}.features USING btree (polyid);
CREATE INDEX {{schema}}_features_categoria_idx ON {{schema}}.features USING btree (categoria);
CREATE INDEX {{schema}}_features_motivacao_idx ON {{schema}}.features USING btree (motivacao);
CREATE INDEX {{schema}}_features_proj_ativo_idx ON {{schema}}.features USING btree (proj_ativo);
CREATE INDEX {{schema}}_features_projeto_idx ON {{schema}}.features USING btree (projeto);
CREATE INDEX {{schema}}_features_met_princ_idx ON {{schema}}.features USING btree (met_princ);
CREATE INDEX {{schema}}_features_monitorada_idx ON {{schema}}.features USING btree (monitorada);
CREATE INDEX {{schema}}_features_tipo_area_idx ON {{schema}}.features USING btree (tipo_area);
-- cd_country , cd_regiao , cd_bioma, cd_geouf , cd_geocmu
CREATE INDEX {{schema}}_features_cd_country_idx ON {{schema}}.features USING btree (cd_country);
CREATE INDEX {{schema}}_features_cd_regiao_idx ON {{schema}}.features USING btree (cd_regiao);
CREATE INDEX {{schema}}_features_cd_bioma_idx ON {{schema}}.features USING btree (cd_bioma);
CREATE INDEX {{schema}}_features_cd_geouf_idx ON {{schema}}.features USING btree (cd_geouf);
CREATE INDEX {{schema}}_features_cd_geocmu_idx ON {{schema}}.features USING btree (cd_geocmu);
-- amaz_legal amacro matopiba
CREATE INDEX {{schema}}_features_amaz_legal_idx ON {{schema}}.features USING btree (amaz_legal);
CREATE INDEX {{schema}}_features_amacro_idx ON {{schema}}.features USING btree (amacro);
CREATE INDEX {{schema}}_features_matopiba_idx ON {{schema}}.features USING btree (matopiba);
-- cd_macro_rh cd_meso_rh cd_micro_rh
CREATE INDEX {{schema}}_features_cd_macro_rh_idx ON {{schema}}.features USING btree (cd_macro_rh);
CREATE INDEX {{schema}}_features_cd_meso_rh_idx ON {{schema}}.features USING btree (cd_meso_rh);
CREATE INDEX {{schema}}_features_cd_micro_rh_idx ON {{schema}}.features USING btree (cd_micro_rh);





CREATE TABLE IF NOT EXISTS {{schema}}.features_estra_rest
(
    uuid    uuid not null
        constraint fk_{{schema}}_feature_estra_rest_id
            references {{schema}}.features,
    code_key text not null
        constraint fk_{{schema}}_estra_rest_id
            references options.estra_rest,
    constraint pk_features_estra_rest
        primary key (uuid, code_key)
);

CREATE INDEX {{schema}}_features_estra_rest_uuid_idx ON {{schema}}.features_estra_rest USING btree (uuid);
CREATE INDEX {{schema}}_features_estra_rest_code_key_idx ON {{schema}}.features_estra_rest USING btree (code_key);


CREATE TABLE IF NOT EXISTS {{schema}}.features_met_comb
(
    uuid    uuid not null
        constraint fk_{{schema}}_feature_met_comb_id
            references {{schema}}.features,
    code_key text not null
        constraint fk_{{schema}}_met_comb_id
            references options.met_comb,
    constraint pk_features_met_comb
        primary key (uuid, code_key)
);


CREATE INDEX {{schema}}_features_met_comb_uuid_idx ON {{schema}}.features_met_comb USING btree (uuid);
CREATE INDEX {{schema}}_features_met_comb_code_key_idx ON {{schema}}.features_met_comb USING btree (code_key);

   
alter table "{{schema}}".features
    owner to orr_master;

alter table "{{schema}}".features_met_comb
    owner to orr_master;

alter table "{{schema}}".features_estra_rest
    owner to orr_master;
        
GRANT ALL PRIVILEGES ON TABLE "{{schema}}".features TO {{schema}}_user;
GRANT ALL PRIVILEGES ON TABLE "{{schema}}".features_met_comb TO {{schema}}_user;
GRANT ALL PRIVILEGES ON TABLE "{{schema}}".features_estra_rest TO {{schema}}_user;


GRANT USAGE ON SCHEMA "{{schema}}" TO PUBLIC;
GRANT SELECT ON TABLE "{{schema}}".features TO PUBLIC;
GRANT SELECT ON TABLE "{{schema}}".features_estra_rest TO PUBLIC;
GRANT SELECT ON TABLE "{{schema}}".features_met_comb  TO PUBLIC;


