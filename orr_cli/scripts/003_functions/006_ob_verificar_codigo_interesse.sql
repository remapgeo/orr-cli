CREATE OR REPLACE FUNCTION ob_verificar_codigo_interesse(
    destiny_schema text, cd_country int, cd_regiao INT, cd_bioma INT,
     cd_geouf int, amaz_legal bool, matopiba bool, amacro bool,  cd_geomun int,
    cd_macro_rh INT,cd_meso_rh INT,cd_micro_rh INT, geometry Geometry(Multipolygon,4674)
)
RETURNS  bool AS
$$
DECLARE
    destiny_table orr_metadata.institutions;
BEGIN
    select * from orr_metadata.institutions where name = destiny_schema limit 1 into destiny_table;
    IF destiny_table.name is NULL then
         raise notice 'error in %', destiny_schema;
        return false;
    end if;
    if verificar_codigo_interesse_interno( cd_country,destiny_table.area_interest_country) then
        raise notice '% in brasil', destiny_schema;
        return true;
    end if;
    if verificar_codigo_interesse_interno( cd_bioma,destiny_table.area_interest_cd_bioma) then
        raise notice '% in bioma', destiny_schema;
        return true;
    end if;
    if verificar_codigo_interesse_interno( cd_regiao,destiny_table.area_interest_cd_regiao) then
        raise notice '% in regiao', destiny_schema;
        return true;
    end if;
    if amaz_legal = destiny_table.area_interest_amz_legal and destiny_table.area_interest_amz_legal then
        raise notice '% in amazonia legal', destiny_schema;
        return true;
    end if;
    if matopiba = destiny_table.area_interest_matopiba and destiny_table.area_interest_matopiba then
        raise notice '% in matopiba', destiny_schema;
        return true;
    end if;
    if amacro = destiny_table.area_interest_amacro and destiny_table.area_interest_amacro then
        raise notice '% in amacro', destiny_schema;
        return true;
    end if;
    if verificar_codigo_interesse_interno( cd_macro_rh,destiny_table.area_interest_cd_macro_rh) then
        raise notice '% in macro hidro', destiny_schema;
        return true;
    end if;
    if verificar_codigo_interesse_interno( cd_meso_rh,destiny_table.area_interest_cd_meso_rh) then
        raise notice '% in meso hidro', destiny_schema;
        return true;
    end if;
    if verificar_codigo_interesse_interno( cd_micro_rh,destiny_table.area_interest_cd_micro_rh) then
        raise notice '% in micro hidro', destiny_schema;
        return true;
    end if;
    if verificar_codigo_interesse_interno( cd_geouf,destiny_table.area_interest_cd_estado) then
        raise notice '% in estado', destiny_schema;
        return true;
    end if;
    if verificar_codigo_interesse_interno( cd_geomun,destiny_table.area_interest_cd_mun) then
        raise notice '% in municipio', destiny_schema;
        return true;
    end if;
    if ob_get_interesection(destiny_table.area_interest_geom,geometry ) then
        raise notice '% gemetry interesse', destiny_schema;
        return true;
    end if;
    raise notice '% nenhum interesse', destiny_schema;

    return false;
END;
$$ LANGUAGE plpgsql;