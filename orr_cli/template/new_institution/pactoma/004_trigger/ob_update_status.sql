CREATE OR REPLACE FUNCTION "{{schema}}".ob_update_status()
RETURNS trigger AS
$BODY$
DECLARE
    meta record;
    regiao region_code;
    hidro hidro_code;
    geom geometry;
BEGIN
    geom := NEW.geom;
    select * from get_region(geom) into regiao;
    select * from get_hidro(geom) into hidro;



    for meta in select name from orr_metadata.institutions loop
        if ob_verificar_codigo_interesse(meta.name,
           regiao.cd_country,
           regiao.cd_regiao,
           regiao.cd_bioma,
           regiao.cd_geouf,
           regiao.amaz_legal,
           regiao.matopiba,
           regiao.amacro,
           regiao.cd_geocmu,
           hidro.cd_macro_rh,
           hidro.cd_meso_rh,
           hidro.cd_micro_rh,
           geom
           ) OR meta.name = '{{schema}}' then
                perform ob_insert_status(NEW.uuid, '{{schema}}', meta.name);
        end if;
        end loop;
        RETURN NEW;

END;
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER trigger_ob_update_status_{{schema}}
AFTER INSERT OR UPDATE ON "{{schema}}".features
FOR EACH ROW
EXECUTE FUNCTION "{{schema}}".ob_update_status();


GRANT EXECUTE ON FUNCTION "{{schema}}".ob_update_status() TO {{schema}}_user;