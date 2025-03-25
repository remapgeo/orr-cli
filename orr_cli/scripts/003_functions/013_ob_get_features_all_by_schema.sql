
-- DONE retirar reflorestamento
CREATE OR REPLACE FUNCTION public.get_features_all_by_schema(schema_name text, lang text DEFAULT 'pt'::text)
 RETURNS TABLE(uuid uuid, fonte_schema character varying, status status_enum, geom geometry, polyid character varying, id numeric, categoria character varying, projeto character varying, nm_projeto character varying, inst_exec character varying, inst_gest character varying, inst_finan character varying, met_princ character varying, met_comb text,  motivacao character varying, tipo_area character varying, dat_inicio ob_date, dat_concl ob_date, proj_ativo character varying, area_decl double precision, monitorada character varying, fonte character varying, link character varying, privac_area character varying, area_ha_calc double precision, cd_country smallint, regiao character varying, cd_regiao smallint, bioma character varying, cd_bioma smallint, amacro boolean, amaz_legal boolean, matopiba boolean, estado character varying, cd_geouf bigint, municipio character varying, cd_geocmu bigint, nm_macro_rh character varying, cd_macro_rh smallint, nm_meso_rh character varying, cd_meso_rh bigint, nm_micro_rh character varying, cd_micro_rh bigint, geohash character varying, created_at timestamp with time zone, updated_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
    schema_name_rec1 RECORD;
    sql_text text;
    sql_loop text;
    suffix text;
BEGIN
    sql_loop := format('select distinct a.schema_name, inst.suffix from %s.status_features a join orr_metadata.institutions inst on inst.name = a.schema_name;',
                schema_name);
    FOR schema_name_rec1 IN
        execute sql_loop
    LOOP
        suffix := '';
        if schema_name_rec1.suffix is not null then
            suffix :=  '_'  || schema_name_rec1.suffix;
        end if;
            sql_text := format('SELECT ft.uuid, ft.fonte_schema, st.status, 
            ft.geom, ft.polyid, ft.id, op_cat.'|| lang ||' AS categoria, op_pja.'|| lang ||' 
            AS projeto, ft.nm_projeto , ft.inst_exec, ft.inst_gest, 
            ft.inst_finan, op_mrs.'|| lang ||' AS met_princ, 
            STRING_AGG(met_comb.'|| lang ||', '', '') AS met_comb, op_mot.'|| lang ||'
             AS motivacao, op_tip.'|| lang ||' AS tipo_area, ft.dat_inicio, 
             ft.dat_concl, op_pjt.'|| lang ||' AS proj_ativo, ft.area_decl,  
             op_mon.'|| lang ||' AS monitorada, ft.fonte, ft.link, op_pri.'|| lang ||' 
             AS privac_area, ft.area_ha_calc, regiao.cd_country, regiao.regiao,
              regiao.cd_regiao, regiao.bioma, regiao.cd_bioma, regiao.amacro,
               regiao.amaz_legal, regiao.matopiba, regiao.estado, regiao.cd_geouf, 
               regiao.municipio, regiao.cd_geocmu, hidro.nm_macro_rh, hidro.cd_macro_rh,
                hidro.nm_meso_rh, hidro.cd_meso_rh, hidro.nm_micro_rh, hidro.cd_micro_rh, 
                ft.geohash, ft.created_at, ft.updated_at ' ||
            'FROM ' ||
             schema_name_rec1.schema_name || '.features ft ' ||
            'LEFT JOIN  ' ||  
            schema_name || '.status_features st ON st.uuid = ft.uuid ' ||
            'LEFT JOIN  ' ||
            'options.categoria'||suffix||' op_cat ON op_cat.code_key = ft.categoria ' ||
            'LEFT JOIN ' ||
            '    options.projeto'||suffix||' op_pja ON op_pja.code_key = ft.projeto '||
            'LEFT JOIN '||
            '    options.met_princ'||suffix||' op_mrs ON op_mrs.code_key = ft.met_princ ' ||
      
            'LEFT JOIN ' ||
            '    options.motivacao'||suffix||' op_mot ON op_mot.code_key = ft.motivacao ' ||
            'LEFT JOIN ' ||
            '    options.tipo_area'||suffix||' op_tip ON op_tip.code_key = ft.tipo_area ' ||
            'LEFT JOIN ' ||
            '    options.proj_ativo'||suffix||' op_pjt ON op_pjt.code_key = ft.proj_ativo ' ||
            'LEFT JOIN ' ||
            '    options.monitorada'||suffix||' op_mon ON op_mon.code_key = ft.monitorada ' ||
            'LEFT JOIN ' ||
            '    options.privac_area'||suffix||' op_pri ON op_pri.code_key = ft.privac_area ' ||
            'LEFT JOIN ' ||
            '    orr_metadata.regions regiao ON regiao.objectid = ft.regiao_objectid ' ||
            'LEFT JOIN ' ||
            '    orr_metadata.hidro_regions hidro ON hidro.objectid = ft.hidro_objectid ' ||
            'LEFT JOIN ' ||
            schema_name_rec1.schema_name || '.features_met_comb'|| suffix ||' ft_to_mt ON ft.uuid = ft_to_mt.uuid ' ||
            'LEFT JOIN ' ||
            '    options.met_comb'|| suffix ||'  met_comb ON ft_to_mt.code_key = met_comb.code_key ' ||
            'LEFT JOIN ' ||
            schema_name_rec1.schema_name || '.features_estra_rest'|| suffix ||' ft_to_er ON ft.uuid = ft_to_er.uuid ' ||
            'LEFT JOIN ' ||
            '    options.estra_rest'|| suffix ||'  er_comb ON ft_to_er.code_key = er_comb.code_key ' ||
            'GROUP BY ft.uuid, ft.fonte_schema, st.status, op_cat.code_key, op_pja.code_key, op_mrs.code_key, 
            op_mot.code_key, op_tip.code_key, op_pjt.code_key, op_mon.code_key, op_pri.code_key, 
            regiao.cd_country, regiao.regiao, regiao.cd_regiao, regiao.bioma, regiao.cd_bioma, 
            regiao.amacro, regiao.amaz_legal, regiao.matopiba, regiao.estado, regiao.cd_geouf, 
            regiao.municipio, regiao.cd_geocmu, hidro.nm_macro_rh, hidro.cd_macro_rh, hidro.nm_meso_rh,
             hidro.cd_meso_rh, hidro.nm_micro_rh, hidro.cd_micro_rh;'
                );
        raise notice '%', sql_text;
        return query execute sql_text;

    end loop;
    END;
$function$
;
