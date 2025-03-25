
-- REVIEW: escrita da MV com || variavel ||
-- REVIEW adicionei full name para a MV p/ geobyte mostrar 
-- DONE remover reflorestamento
-- DONE fonte como full name
-- DONE estrategia rest
-- DROP FUNCTION public.ob_get_features_by_schema(text);
CREATE OR REPLACE FUNCTION public.ob_get_features_by_schema(schema_name text)
RETURNS TABLE(
    uuid uuid,      --  1
    fonte_schema character varying,         --  2
    status status_enum,         --  3
    geom geometry,      --  4
    polyid character varying,       --  5
    row_id numeric,         --  6
    categoria character varying,        --  7
    projeto character varying,      --  8
    nm_projeto character varying,       --  9
    inst_exec character varying,        --  10
    inst_gest character varying,        --  11
    inst_finan character varying,       --  12
    met_princ character varying,        --  13
    met_comb text,      --  14
    estra_rest text,        --  15
    motivacao character varying,        --  16
    tipo_area character varying,        --  17
    dat_inicio ob_date,         --  18
    dat_concl ob_date,      --  19
    proj_ativo character varying,       --  20
    area_decl double precision,         --  21
    monitorada character varying,       --  22
    fonte text,        --  23
    link character varying,         --  24
    privac_area character varying,      --  25
    area_ha_calc double precision,      --  26
    cd_country smallint,        --  27
    regiao character varying,       --  28
    cd_regiao smallint,         --  29
    bioma character varying,        --  30
    cd_bioma smallint,      --  31
    amacro boolean,         --  32
    amaz_legal boolean,         --  33
    matopiba boolean,       --  34
    estado character varying,       --  35
    cd_geouf bigint,        --  36
    municipio character varying,        --  37
    cd_geocmu bigint,       --  38
    nm_macro_rh character varying,      --  39
    cd_macro_rh smallint,       --  40
    nm_meso_rh character varying,       --  41
    cd_meso_rh bigint,      --  42
    nm_micro_rh character varying,      --  43
    cd_micro_rh bigint,         --  44
    geohash character varying,      --  45
    created_at timestamp with time zone,        --  46
    updated_at timestamp with time zone     --  47
)
LANGUAGE plpgsql
AS $function$
DECLARE
    schema_name_rec1 RECORD;
    sql_text text ;
    sql_loop text;
    full_name varchar;
    sufix text;
BEGIN
    sql_loop := 'select distinct a.schema_name, inst.suffix, inst.full_name from '||schema_name||'.status_features a
 join orr_metadata.institutions inst on inst.name = a.schema_name;';
    FOR schema_name_rec1 IN
        execute sql_loop
    LOOP
        sufix := '';
        full_name := schema_name_rec1.full_name;
       
        if schema_name_rec1.suffix is not null then
            sufix :=  '_'  || schema_name_rec1.suffix;
           full_name := schema_name_rec1.full_name;
        end if;
        raise notice '%', sql_loop;
       raise notice 'full name: %', quote_literal(full_name);
        sql_text := 'SELECT 
        ft.uuid,         --1
        ft.fonte_schema,        --2
         st.status,         --3
         ft.geom,        --4
        ft.polyid,        --5
        ft.id,        --6
        op_cat.pt AS categoria,        --7
        op_pja.pt AS projeto,         --8
        ft.nm_projeto ,         --9
        ft.inst_exec,         --10
         ft.inst_gest,          --11
        ft.inst_finan,          --12
        op_mrs.pt AS met_princ,         --13
        STRING_AGG(met_comb.pt, '', '')::text AS met_comb,          --14
      	er_comb.pt::text AS estra_rest,   --15
        op_mot.pt AS motivacao,         --16
         op_tip.pt AS tipo_area,         --17
        ft.dat_inicio,         --18
        ft.dat_concl,          --19
        op_pjt.pt AS proj_ativo,          --20
        ft.area_decl,          --21
        op_mon.pt AS monitorada,        --22
        '|| quote_literal(full_name) || ' as fonte,         --23
        ft.link,          --24
        op_pri.pt AS privac_area,          --25
        ft.area_ha_calc,         --26
         regiao.cd_country,         --27
          regiao.regiao,          --28
          regiao.cd_regiao,         --29
           regiao.bioma,         --30
        regiao.cd_bioma,         --31
        regiao.amacro,          --32
        regiao.amaz_legal,         --33
         regiao.matopiba,          --34
         regiao.estado,         --35
          regiao.cd_geouf,          --36
          regiao.municipio,         --37
           regiao.cd_geocmu,          --38
           hidro.nm_macro_rh,          --39
        hidro.cd_macro_rh,         --40
        hidro.nm_meso_rh,          --41
        hidro.cd_meso_rh,         --42
         hidro.nm_micro_rh,         --43
          hidro.cd_micro_rh,          --44
          ft.geohash,          --45
          ft.created_at,          --46
          ft.updated_at          --47
        FROM ' || schema_name_rec1.schema_name ||'.features ft ' ||
        'LEFT JOIN  ' ||schema_name ||'.status_features st ON st.uuid = ft.uuid ' ||
        'LEFT JOIN  ' ||
        '    options.categoria'||sufix||' op_cat ON op_cat.code_key = ft.categoria ' ||
        'LEFT JOIN ' ||
        '    options.projeto'||sufix||'  op_pja ON op_pja.code_key = ft.projeto '||
        'LEFT JOIN '||
        '    options.met_princ'||sufix||'  op_mrs ON op_mrs.code_key = ft.met_princ ' ||
        'LEFT JOIN ' ||
        '    options.motivacao'||sufix||'  op_mot ON op_mot.code_key = ft.motivacao ' ||
        'LEFT JOIN ' ||
        '    options.tipo_area'||sufix||' op_tip ON op_tip.code_key = ft.tipo_area ' ||
        'LEFT JOIN ' ||
        '    options.proj_ativo'||sufix||' op_pjt ON op_pjt.code_key = ft.proj_ativo ' ||
        'LEFT JOIN ' ||
        '    options.monitorada'||sufix||' op_mon ON op_mon.code_key = ft.monitorada ' ||
        'LEFT JOIN ' ||
        '    options.privac_area'||sufix||' op_pri ON op_pri.code_key = ft.privac_area ' ||
        'LEFT JOIN ' ||
        '    orr_metadata.regions regiao ON regiao.objectid = ft.regiao_objectid ' ||
        'LEFT JOIN ' ||
        '    orr_metadata.hidro_regions hidro ON hidro.objectid = ft.hidro_objectid ' ||
        'LEFT JOIN ' ||
             schema_name_rec1.schema_name ||'.features_met_comb'||sufix||'  ft_to_mt ON ft.uuid = ft_to_mt.uuid ' ||
        'LEFT JOIN ' ||
        '    options.met_comb'||sufix||'  met_comb ON ft_to_mt.code_key = met_comb.code_key ' ||
        'LEFT JOIN ' ||
             schema_name_rec1.schema_name ||'.features_estra_rest'||sufix||'  ft_to_er ON ft.uuid = ft_to_er.uuid ' ||
        'LEFT JOIN ' ||
        '    options.estra_rest'||sufix||'  er_comb ON ft_to_er.code_key = er_comb.code_key ' ||
        'where st.uuid = ft.uuid and st.status  = ''APPROVED''::status_enum ' ||
        'GROUP BY ft.uuid, ft.fonte_schema, st.status, op_cat.code_key, op_pja.code_key, op_mrs.code_key, '||
        'er_comb.pt, '
        'op_mot.code_key, op_tip.code_key, op_pjt.code_key, op_mon.code_key, op_pri.code_key, regiao.cd_country, regiao.regiao, '||
        'regiao.cd_regiao, regiao.bioma, regiao.cd_bioma, regiao.amacro, regiao.amaz_legal, regiao.matopiba, regiao.estado, regiao.cd_geouf, '||
        'regiao.municipio, regiao.cd_geocmu, hidro.nm_macro_rh, hidro.cd_macro_rh, hidro.nm_meso_rh, hidro.cd_meso_rh, hidro.nm_micro_rh, hidro.cd_micro_rh;' ;
        raise notice 'SQL TEXT %', sql_text;
      IF sql_text IS NOT NULL AND sql_text <> '' THEN
        RETURN QUERY EXECUTE sql_text;
      ELSE
        RAISE NOTICE 'Nenhum registro encontrado para o schema: %', schema_name;
    END IF;

    end loop;
END;
$function$;