CREATE OR REPLACE FUNCTION public.get_hidro(geom geometry)
 RETURNS hidro_code
 LANGUAGE plpgsql
AS $function$
    declare
        returned_hidro hidro_code;
BEGIN
      SELECT
        hidro_regions.objectid::int,
        hidro_regions.cd_macro_rh::int,
        hidro_regions.cd_meso_rh::int,
        hidro_regions.cd_micro_rh::int
    FROM
        orr_metadata.hidro_regions hidro_regions
    WHERE ST_Intersects(geom, hidro_regions.geometry)
    ORDER BY
         ST_Area(ST_Intersection(geom,hidro_regions.geometry) )
         DESC
    LIMIT 1 into returned_hidro;
      return returned_hidro;
END;
$function$
;