-- DONE retirar reflorestamento da checagem de unique
CREATE OR REPLACE FUNCTION "{{schema}}".is_unique()
RETURNS trigger AS
$BODY$
DECLARE
    existing_geom geometry;
    existing_version INTEGER;
BEGIN

    -- Busca a geometria e a versão existente com as mesmas características
    SELECT geom, data_version
    INTO existing_geom, existing_version
    FROM "{{schema}}".features
        WHERE ST_GeoHash(ST_Centroid(NEW.geom),16) = geohash 
        AND COALESCE(NEW.categoria, 'cat00') = categoria
      AND COALESCE(NEW.projeto, 'pro00') = projeto 
      AND NEW.dat_inicio = dat_inicio 
      AND COALESCE(NEW.met_princ,'mrs00' ) = met_princ 
      AND COALESCE(NEW.inst_exec,'Não identificado' ) = inst_exec 
      AND COALESCE(NEW.inst_gest, 'Não identificado') = inst_gest
      AND COALESCE(NEW.inst_finan, 'Não identificado') = inst_finan 
       
      AND COALESCE(NEW.motivacao, 'mon00') = motivacao 
      AND COALESCE(NEW.proj_ativo,'pja00' ) =proj_ativo
      
      AND COALESCE(NEW.monitorada,'mon00' ) = monitorada 
      AND COALESCE(NEW.tipo_area, 'tip00') = tipo_area 
      AND COALESCE(NEW.data_version,1) = data_version
    LIMIT 1;

    IF FOUND THEN

        -- Verifica se a diferença de área é maior que 0.01 hectares (100 m²)
        IF abs(ST_Area(NEW.geom::geography)/10000 - ST_Area(existing_geom::geography)/10000) > 0.005 THEN
            NEW.data_version = COALESCE(existing_version, 1) + 1;
        ELSE
            RAISE EXCEPTION 'Conflict in the information: Area may be repeated';
            return null;
        END IF;
    END IF;

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER trigger_ob_is_unique_{{schema}}unique
BEFORE INSERT OR UPDATE OF geom ON "{{schema}}".features
FOR EACH ROW
EXECUTE FUNCTION "{{schema}}".is_unique();


GRANT EXECUTE ON FUNCTION "{{schema}}".is_unique() TO {{schema}}_user;