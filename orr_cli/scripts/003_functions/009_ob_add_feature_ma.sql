-- TODO: checar colunas da função
-- DONE: remover st_multi
-- TODO: Passar regiao para triggers
CREATE OR REPLACE FUNCTION  public.ob_add_feature_ma(
    IN insert_shema_name text, 
    IN wkt_geom text, 
    IN polyid text, 
    IN id integer, 
    IN categoria character varying, 
    IN projeto character varying, 
    IN nm_projeto character varying, 
    IN origem character varying, 
    IN idpacto character varying, 
    IN inst_exec character varying, 
    IN inst_gest character varying, 
    IN inst_finan character varying, 
    IN met_princ character varying,
    IN uso_ant text, 
    IN motivacao character varying, 
    IN tipo_area character varying, 
    IN dat_inicio text, 
    IN proj_ativo character varying, 
    IN dat_concl text, 
    IN area_decl double precision, 
    IN monitorada character varying, 
    IN prot_monit character varying, 
    IN freq_monit character varying, 
    IN ano_prev character varying,
    IN ano_prev_t character varying, 
    IN fonte character varying, 
    IN link character varying, 
    IN privac_area character varying, 
    IN features_met_comb_ma text[]
)
RETURNS UUID
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    f_uuid uuid;
    f_geom geometry;
    regiao region_code;
    hidro hidro_code;
    f_text text;
    loop_index int;
BEGIN

    SELECT ST_GeomFromText(wkt_geom) into f_geom;
    select * from get_region(f_geom) into regiao;
    select * from get_hidro(f_geom) into hidro;
    
    if polyid is null then
        polyid := SUBSTRING(uuid_generate_v4(),1,13);
    end if;

    f_text := format('insert into %s.features (
        geom, polyid, id, categoria, projeto, nm_projeto, inst_exec, inst_gest, inst_finan, met_princ, 
        uso_ant, 
         motivacao, origem, idpacto,
        tipo_area, dat_inicio, proj_ativo, dat_concl, area_decl, monitorada,  prot_monit,   freq_monit, ano_prev,ano_prev_t,fonte, link, privac_area
        )values (

       $1 ,       --    geom ,
       $2 ,       --    polyid,
       $3 ,       --    id  ,    
       $4 ,       --    categoria  , 
       $5 ,       --    projeto  , 
       $6 ,       --    nm_projeto,  
       $7 ,       --     inst_exec , 
       $8 ,       --     inst_gest ,
       $9 ,       --     inst_finan    ,  
       $10 ,       --     met_princ,
       $11 ,       --     uso_ant , 
       $12 ,       --     motivacao ,  
       $13 ,               -- origem,
       $14 ,               -- idpacto,
       $15 ,       --     tipo_area   ,
       $16 ,       --     dat_inicio::text ,
       $17  ,       --     proj_ativo   ,
       $18  ,       --     dat_concl::text,   
       $19  ,       --     area_decl ,  
       $20  ,       --     monitorada  ,
       $21  ,       --     prot_monit  ,
       $22  ,       --     freq_monit  ,
       $23  ,          -- ano_prev,
       $24  ,       --     ano_prev_t  ,
       $25  ,       --     fonte      ,
       $26  ,       --     link       ,
       $27          --     privac_area  ,  
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
        uso_ant,
        motivacao,
        origem,
        idpacto,
        tipo_area,
        ob_date_format(dat_inicio) ,
        proj_ativo,
        ob_date_format(dat_concl) ,
        area_decl,
        monitorada,
        prot_monit ,
        freq_monit,
        ob_date_format(ano_prev),
        ob_date_format(ano_prev_t),
        fonte,
        link,
        privac_area;
        

        raise notice '%', f_uuid;

        if array_length(features_met_comb_ma,1) IS NOT NULL THEN
            for loop_index in 1..array_length(features_met_comb_ma, 1) loop
                execute format('INSERT INTO %s.features_met_comb_ma(uuid, code_key)
                    VALUES($1, $2);', insert_shema_name)
                using
                f_uuid,
                features_met_comb_ma[loop_index];
            end loop;
        END IF;
    RETURN f_uuid;

END;
$procedure$
;