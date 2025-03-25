
-- DONE adicionar index nas MVs também


create materialized view "{{schema}}".mv_intersec_intern as
select distinct fo.uuid uuid_base ,fe.uuid as uuid_compare,  fe.geom as geom_base, fo.geom as geom_compare,
    st_intersects(fe.geom, fo.geom), st_touches(fe.geom, fo.geom), st_within(fe.geom, fo.geom),
    st_covers(fe.geom, fo.geom),  st_area(st_intersection(fe.geom::geography, fo.geom::geography)) / 10000 as area_ha,
    st_area(st_intersection(fe.geom, fo.geom)) * 100 / st_area(fe.geom) as porcentagem
from "{{schema}}".features fe, "{{schema}}".features fo
where  fe.uuid <> fo.uuid  and st_intersects(fe.geom, fo.geom) or st_touches(fe.geom, fo.geom);

alter materialized view  "{{schema}}".mv_intersec_intern  owner to orr_master;

CREATE INDEX {{schema}}_mv_intersec_intern_uuid_base on  {{schema}}.mv_intersec_intern USING btree (uuid_base);
CREATE INDEX {{schema}}_mv_intersec_intern_uuid_compare on  {{schema}}.mv_intersec_intern USING btree (uuid_compare);
CREATE INDEX {{schema}}_mv_intersec_intern_area_ha on {{schema}}.mv_intersec_intern USING btree (area_ha);
CREATE INDEX {{schema}}_mv_intersec_intern_geom_base on  {{schema}}.mv_intersec_intern USING GIST(geom_base);
CREATE INDEX {{schema}}_mv_intersec_intern_geom_comp on  {{schema}}.mv_intersec_intern USING GIST(geom_compare);


GRANT SELECT ON TABLE "{{schema}}".mv_intersec_intern  TO PUBLIC;