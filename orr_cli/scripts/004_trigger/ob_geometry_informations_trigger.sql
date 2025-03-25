CREATE OR REPLACE FUNCTION ob_geometry_informations_trigger()
RETURNS trigger AS
$BODY$
DECLARE
    regiao region_code;
    hidro hidro_code;
    area_ha_calc double precision;
    geom geometry;
BEGIN
    IF ST_IsValid(NEW.geom) = False THEN
        raise Exception 'Geometry is not valid';
        return null;
    else
        geom := NEW.geom;
        select * from get_region(geom) into regiao;
        select * from get_hidro(geom) into hidro;
        select st_area(st_transform(geom,102033)) / 10000 into area_ha_calc;
        if area_ha_calc < 0.01 then
            RAISE EXCEPTION 'The polygon area cannot be less than 0.01 hectares';
            return null;
        end if;

        NEW.area_ha_calc := area_ha_calc;
        NEW.regiao_objectid := regiao.objectid;
        NEW.cd_country  := regiao.cd_country;
        NEW.cd_regiao := regiao.cd_regiao;
        NEW.cd_bioma := regiao.cd_bioma;
        NEW.amaz_legal := regiao.amaz_legal;
        NEW.matopiba := regiao.matopiba;
        NEW.amacro := regiao.amacro;
        NEW.cd_geouf := regiao.cd_geouf;
        NEW.cd_geocmu := regiao.cd_geocmu;
        NEW.hidro_objectid := hidro.objectid;
        NEW.cd_macro_rh := hidro.cd_macro_rh;
        NEW.cd_meso_rh := hidro.cd_meso_rh;
        NEW.cd_micro_rh := hidro.cd_micro_rh;
        NEW.geohash := ST_GeoHash(ST_Centroid(geom), 16);
        NEW.geom := geom;
        
        RETURN NEW;
    end if;
END;
$BODY$
LANGUAGE plpgsql;

/* DONE: add na criçao do features
CREATE TRIGGER "{{schema}}".trigger_update_regiao
BEFORE INSERT OR UPDATE OF geom ON "{{schema}}".features
FOR EACH ROW
EXECUTE FUNCTION update_regiao();
**/