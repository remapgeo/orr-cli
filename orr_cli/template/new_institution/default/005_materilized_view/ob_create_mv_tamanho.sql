
-- DONE adicionar index nas MVs também

CREATE MATERIALIZED VIEW  "{{schema}}".mv_notificacao_area AS 
SELECT  fe.uuid, fe.area_ha_calc ,fe.fonte_schema, fe.fonte, fe.geom, sf."status"
    FROM "{{schema}}".features fe 
    inner join "{{schema}}".status_features sf on fe.uuid=sf.uuid
WHERE fe.area_ha_calc < 0.001 or fe.area_ha_calc > 300;


alter materialized view  "{{schema}}".mv_notificacao_area  owner to orr_master;

CREATE INDEX {{schema}}_mv_notif_area_uuid on  {{schema}}.mv_notificacao_area USING btree (uuid);
CREATE INDEX {{schema}}_mv_notif_area_area on {{schema}}.mv_notificacao_area USING btree (area_ha_calc);
CREATE INDEX {{schema}}_mv_notif_area_geom on  {{schema}}.mv_notificacao_area USING GIST(geom);

GRANT SELECT ON TABLE "{{schema}}".mv_notificacao_area  TO PUBLIC;