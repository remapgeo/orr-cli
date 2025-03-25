-- DONE: função para criar a MV depois

create function calculate_area_colides_all_schemas()
    returns TABLE(schema_record character varying,
                  schema_record2 character varying,
                  uuid_base uuid, uuid_compare uuid,
                  geom_base geometry,
                  geom_compare geometry,
                  touches boolean,
                  equals boolean,
                  intersects boolean,
                  area_ha double precision,
                  porcent_area double precision)
    language plpgsql
as
$$
DECLARE
    schema_name_rec1 RECORD;
    schema_name_rec2 RECORD;
    table_name_rec text;
    sql_text text;

BEGIN
    table_name_rec = 'features';
    FOR schema_name_rec1 IN
        SELECT DISTINCT inst.name
        FROM orr_metadata.institutions inst
    LOOP

         FOR schema_name_rec2 IN
                SELECT DISTINCT inst.name
                FROM orr_metadata.institutions inst
        LOOP

            IF schema_name_rec1.name <> schema_name_rec2.name then

                sql_text := format( 'SELECT ' ||
                        't1.fonte_schema as schema_record,' ||
                        't2.fonte_schema  as schema_record2,' ||
                        't1.uuid as uuid_base,' || --uuid_base
                        ' t2.uuid as uuid_compare,' || -- uuid_compare
                        ' t1.geom,' || -- geom_base
                        ' t2.geom, ' || -- geom_compare
                        ' st_touches(t1.geom, t2.geom), ' || -- touches
                        ' st_equals(t1.geom, t2.geom), ' || -- equals
                        'st_intersects(t1.geom, t2.geom), ' || -- intersects
                        'st_area(st_intersection(t1.geom::geography, t2.geom::geography)) / 10000, ' || --area_ha
                        'st_area(st_intersection(t1.geom, t2.geom)) * 100 / st_area(t1.geom) ' ||-- porcent
                        'FROM %s.%s t1 ' ||
                        'INNER JOIN %s.%s t2 ON ST_Intersects(t1.geom, t2.geom)',
                        schema_name_rec1.name, table_name_rec, schema_name_rec2.name,
                        table_name_rec
                            );

                raise notice '%', sql_text;
                return query EXECUTE sql_text;



            END IF;
        END LOOP;
         END LOOP;
    END;
$$;

alter function calculate_area_colides_all_schemas() owner to orr_master;