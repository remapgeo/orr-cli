-- DONE: retirar multipolygon
create or replace function ob_get_interesection(area_interest Geometry(Polygon,4674),
 features_geom Geometry(Polygon,4674), porcent_threshold float4 default 10, area_ha float4 default 1)
RETURNS  bool AS
$$
DECLARE
    area_percentage FLOAT4;
    intersection_area FLOAT4;
BEGIN
   SELECT st_area(st_transform(st_intersection(area_interest, features_geom), 102033)) / 10000
    INTO intersection_area;

    SELECT st_area(st_intersection(area_interest, features_geom)) * 100 / st_area(features_geom)
    INTO area_percentage;

    IF intersection_area >= area_ha or area_percentage > porcent_threshold  THEN

        RETURN true;

    END IF;
   return false;
END;
$$ LANGUAGE plpgsql;
