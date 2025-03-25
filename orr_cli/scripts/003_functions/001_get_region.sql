
CREATE OR REPLACE FUNCTION public.get_region(geom geometry)
 RETURNS region_code
 LANGUAGE plpgsql
AS $function$
    declare returned_region region_code;
BEGIN
    SELECT
        regions.objectid::int,
        regions.cd_country::int,
        regions.cd_regiao::int,
        regions.cd_bioma::int,
        regions.amaz_legal::boolean,
        regions.matopiba::boolean,
        regions.amacro::boolean,
        regions.cd_geouf::int,
        regions.cd_geocmu::int
    FROM
        orr_metadata.regions regions
    WHERE ST_Intersects(geom, regions.geometry)

    ORDER BY
        ST_Area(ST_Intersection(geom, regions.geometry))
         DESC
    LIMIT 1 into returned_region;
    return returned_region;
END;
$function$
;