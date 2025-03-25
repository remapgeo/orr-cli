/*
A MV VAI PEGAR AS ÁREAS DE RESTAURAÇÃO QUE TEM OS PROBLEMAS DE CIRCULO,
TRIANGULO E LINHAS PARA QUE AVALIEM
*/

-- DONE adicionar index nas MVs também

CREATE MATERIALIZED VIEW  "{{schema}}".mv_notificacao_formato AS 
    SELECT  fe.uuid, 'circulo' as format_geom, fe.fonte_schema, fe.fonte, fe.geom, sf."status"
        FROM "{{schema}}".features fe 
            JOIN "{{schema}}".status_features sf ON fe.uuid = sf.uuid
WHERE is_circle(fe.geom) > 0.99 
UNION 
    SELECT  fe.uuid, 'triangulo' as format_geom, fe.fonte_schema, fe.fonte, fe.geom, sf."status"
        FROM "{{schema}}".features fe  
            JOIN "{{schema}}".status_features sf ON fe.uuid = sf.uuid
WHERE geometrytype(fe.geom) in ('TRIANGULE')    
UNION
    SELECT  fe.uuid, 'linha' as format_geom, fe.fonte_schema, fe.fonte, fe.geom, sf."status"
        FROM "{{schema}}".features fe 
            JOIN "{{schema}}".status_features sf ON fe.uuid = sf.uuid
WHERE geometrytype(fe.geom) IN ('MULTILINESTRING', 'LINESTRING') ;

alter materialized view  "{{schema}}".mv_notificacao_formato  owner to orr_master;

CREATE INDEX {{schema}}_mv_notif_formato_uuid on  {{schema}}.mv_notificacao_formato USING btree (uuid);
CREATE INDEX {{schema}}_mv_notif_formato_form on {{schema}}.mv_notificacao_formato USING btree (format_geom);
CREATE INDEX {{schema}}_mv_notif_formato_geom on  {{schema}}.mv_notificacao_formato USING GIST(geom);


GRANT SELECT ON TABLE "{{schema}}".mv_notificacao_formato  TO PUBLIC;