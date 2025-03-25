create materialized view "{{schema}}".summary as
WITH geomtry AS (SELECT DISTINCT ON (ob_get_features_by_schema.geom) ob_get_features_by_schema.geom,
                    ob_get_features_by_schema.fonte_schema,
                    ob_get_features_by_schema.regiao,
                    ob_get_features_by_schema.cd_regiao,
                    ob_get_features_by_schema.bioma,
                    ob_get_features_by_schema.cd_bioma,
                    ob_get_features_by_schema.amacro,
                    ob_get_features_by_schema.amaz_legal,
                    ob_get_features_by_schema.matopiba,
                    ob_get_features_by_schema.estado,
                    ob_get_features_by_schema.cd_geouf,
                    ob_get_features_by_schema.municipio,
                    ob_get_features_by_schema.cd_geocmu,
                    ob_get_features_by_schema.nm_macro_rh,
                    ob_get_features_by_schema.cd_macro_rh,
                    ob_get_features_by_schema.nm_meso_rh,
                    ob_get_features_by_schema.cd_meso_rh,
                    ob_get_features_by_schema.nm_micro_rh,
                    ob_get_features_by_schema.cd_micro_rh
                 FROM ob_get_features_by_schema('{{schema}}'::text) ob_get_features_by_schema(uuid, fonte_schema, status, geom,
                    polyid, row_id, categoria,
                    projeto, nm_projeto, inst_exec,
                    inst_gest, inst_finan, met_princ,
                    met_comb, estra_rest,
                    motivacao, tipo_area,
                    dat_inicio, dat_concl,
                    proj_ativo, area_decl,
                    monitorada, fonte, link,
                    privac_area, area_ha_calc,
                    cd_country, regiao, cd_regiao,
                    bioma, cd_bioma, amacro,
                    amaz_legal, matopiba, estado,
                    cd_geouf, municipio, cd_geocmu,
                    nm_macro_rh, cd_macro_rh,
                    nm_meso_rh, cd_meso_rh,
                    nm_micro_rh, cd_micro_rh,
                    geohash, created_at, updated_at)
                 GROUP BY ob_get_features_by_schema.geom, ob_get_features_by_schema.fonte_schema,
                          ob_get_features_by_schema.regiao, ob_get_features_by_schema.cd_regiao,
                          ob_get_features_by_schema.bioma, ob_get_features_by_schema.cd_bioma,
                          ob_get_features_by_schema.amacro, ob_get_features_by_schema.amaz_legal,
                          ob_get_features_by_schema.matopiba, ob_get_features_by_schema.estado,
                          ob_get_features_by_schema.cd_geouf, ob_get_features_by_schema.municipio,
                          ob_get_features_by_schema.cd_geocmu, ob_get_features_by_schema.nm_macro_rh,
                          ob_get_features_by_schema.cd_macro_rh, ob_get_features_by_schema.nm_meso_rh,
                          ob_get_features_by_schema.cd_meso_rh, ob_get_features_by_schema.nm_micro_rh,
                          ob_get_features_by_schema.cd_micro_rh)
SELECT st_area(st_union(geomtry.geom)::geography) / 10000::double precision AS area_ha,
       st_simplify(st_union(geomtry.geom), 0.00001::double precision)       AS geom,
       geomtry.fonte_schema,
       geomtry.regiao,
       geomtry.cd_regiao,
       geomtry.bioma,
       geomtry.cd_bioma,
       geomtry.amacro,
       geomtry.amaz_legal,
       geomtry.matopiba,
       geomtry.estado,
       geomtry.cd_geouf,
       geomtry.municipio,
       geomtry.cd_geocmu,
       geomtry.nm_macro_rh,
       geomtry.cd_macro_rh,
       geomtry.nm_meso_rh,
       geomtry.cd_meso_rh,
       geomtry.nm_micro_rh,
       geomtry.cd_micro_rh
FROM geomtry
GROUP BY geomtry.fonte_schema, geomtry.regiao, geomtry.cd_regiao, geomtry.bioma, geomtry.cd_bioma, geomtry.amacro,
         geomtry.amaz_legal, geomtry.matopiba, geomtry.estado, geomtry.cd_geouf, geomtry.municipio, geomtry.cd_geocmu,
         geomtry.nm_macro_rh, geomtry.cd_macro_rh, geomtry.nm_meso_rh, geomtry.cd_meso_rh, geomtry.nm_micro_rh,
         geomtry.cd_micro_rh;

alter materialized view "{{schema}}".summary owner to orr_master;

create index {{schema}}_summary_fonte_schema_idx
    on "{{schema}}".summary (fonte_schema);

create index {{schema}}_summary_cd_regiao_idx
    on "{{schema}}".summary (cd_regiao);

create index {{schema}}_summary_cd_bioma_idx
    on "{{schema}}".summary (cd_bioma);

create index {{schema}}_summary_cd_geouf_idx
    on "{{schema}}".summary (cd_geouf);

create index {{schema}}_summary_cd_geocmu_idx
    on "{{schema}}".summary (cd_geocmu);

create index {{schema}}_summary_cd_macro_rh_idx
    on "{{schema}}".summary (cd_macro_rh);

create index {{schema}}_summary_cd_meso_rh_idx
    on "{{schema}}".summary (cd_meso_rh);

create index {{schema}}_summary_cd_micro_rh_idx
    on "{{schema}}".summary (cd_micro_rh);

grant select on "{{schema}}".summary to public;

