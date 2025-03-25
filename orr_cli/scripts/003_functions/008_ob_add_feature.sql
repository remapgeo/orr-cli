--REVIEW: checar colunas da função
--DONE: remover st_multi

CREATE OR REPLACE FUNCTION public.ob_add_feature(
    IN insert_shema_name text, 
    IN wkt_geom text,
    IN polyid text,
    IN id integer,
    IN categoria character varying, 
    IN projeto character varying,
    IN nm_projeto character varying,
    IN inst_exec character varying,
    IN inst_gest character varying,
    IN inst_finan character varying,
    IN met_princ character varying,
    IN motivacao character varying,
    IN tipo_area character varying, 
    IN dat_inicio text,
    IN proj_ativo character varying,
    IN dat_concl text,
    IN area_decl double precision, 
    IN monitorada character varying,
    IN fonte character varying, 
    IN link character varying,
    IN privac_area character varying,
    IN features_met_comb text[]
)
RETURNS UUID
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    f_uuid uuid;
    f_geom geometry;
    regiao region_code;
    hidro hidro_code;
    area_ha_calc double precision;
    f_text text;
    loop_index int;
BEGIN

    SELECT ST_GeomFromText(wkt_geom) into f_geom;
    select * from get_region(f_geom) into regiao;
    select * from get_hidro(f_geom) into hidro;

    f_text := format('insert into %s.features (geom, polyid, id, categoria, projeto, nm_projeto, inst_exec, inst_gest, 
        inst_finan, met_princ, 
         motivacao,  tipo_area, dat_inicio, proj_ativo, dat_concl,
         monitorada,fonte, area_decl, link, privac_area
        )values (
            $1  ,              --   geom
            $2  ,              --   polyid
            $3  ,              --   id
            $4  ,              --   categoria,
            $5  ,              --   projeto,
            $6  ,              --   nm_projeto,
            $7  ,              --   inst_exec , 
            $8  ,              --   inst_gest ,
            $9  ,              --   inst_finan  ,  
            $10  ,              --   met_princ,
            $11  ,              --   motivacao,
            $12  ,              --   tipo_area,
            $13  ,              --   dat_inicio,
            $14  ,              --   proj_ativo,
            $15  ,              --   dat_concl::text,
            $16  ,              --   monitorada,
            $17  ,              --   fonte,
            $18  ,              --   area_decl
            $19  ,              --   link,
            $20               --   privac_area
         ) RETURNING uuid',
        insert_shema_name);
        execute f_text
        into f_uuid
        using
        f_geom,
        polyid,
        id,
        categoria,
        projeto,
        nm_projeto,
        inst_exec, 
        inst_gest, 
        inst_finan,
        met_princ,
        motivacao,
        tipo_area,
        ob_date_format(dat_inicio) ,
        proj_ativo,
        ob_date_format(dat_concl) ,
        monitorada,
        fonte,
        area_decl,
        link,
        privac_area;

        raise notice '%', f_uuid;

         if array_length(features_met_comb,1) IS NOT NULL THEN
            for loop_index in 1..array_length(features_met_comb, 1) loop
                execute format('INSERT INTO %s.features_met_comb(uuid, code_key)
                    VALUES($1, $2);', insert_shema_name)
                using
                f_uuid,
                features_met_comb[loop_index];
            end loop;
        END IF;
        
RETURN f_uuid;
        
END;
$procedure$
;
