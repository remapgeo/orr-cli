-- DONE adicionar index nas MVs também
create materialized view "{{schema}}".mv_features as
select * from ob_get_features_by_schema('{{schema}}') where status = 'APPROVED'::status_enum ;

alter materialized view  "{{schema}}".mv_features  owner to orr_master;

CREATE INDEX {{schema}}_mv_features_uuid on  {{schema}}.mv_features USING btree (uuid);
CREATE INDEX {{schema}}_mv_features_area_ha_calc on {{schema}}.mv_features USING btree (area_ha_calc);
CREATE INDEX {{schema}}_mv_features_geom on  {{schema}}.mv_features USING GIST(geom);
CREATE INDEX {{schema}}_mv_features_inst_exec on {{schema}}.mv_features USING btree (inst_exec);

GRANT SELECT ON TABLE "{{schema}}".mv_features  TO PUBLIC;
