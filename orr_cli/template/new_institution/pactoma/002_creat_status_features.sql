create table IF NOT EXISTS "{{schema}}".status_features
(
    uuid        uuid not null,
    schema_name varchar(100) not null,
    status      status_enum default 'PENDING'::status_enum not null,
    observation text, 
    constraint status_features_pkey primary key (uuid, schema_name),
    CONSTRAINT unique_uuid_schema_name UNIQUE (uuid, schema_name) 

);
CREATE INDEX {{schema}}_status_features_uuid_idx ON {{schema}}.status_features USING btree (uuid);
CREATE INDEX {{schema}}_status_features_schema_name_schema_name_idx ON {{schema}}.status_features USING btree (schema_name);
CREATE INDEX {{schema}}_status_features_status_idx ON {{schema}}.status_features USING btree (status);



alter table "{{schema}}".status_features
    owner to orr_master;

GRANT ALL PRIVILEGES ON TABLE "{{schema}}".status_features TO {{schema}}_user;

alter table "{{schema}}".status_features
    owner to orr_master;
GRANT ALL PRIVILEGES ON TABLE "{{schema}}".status_features TO orr_master;
GRANT ALL PRIVILEGES ON TABLE "{{schema}}".status_features TO {{schema}}_user;

GRANT select, update, INSERT ON TABLE "{{schema}}".status_features  TO PUBLIC;
