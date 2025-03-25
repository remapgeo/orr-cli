
create table IF NOT EXISTS options.monitorada
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint monitorada_pk
        primary key (code_key)
);
CREATE INDEX options_monitorada_code_key_idx ON options.monitorada USING btree (code_key);
CREATE INDEX options_monitorada_pt_idx ON options.monitorada USING btree (pt);
CREATE INDEX options_monitorada_en_idx ON options.monitorada USING btree (code_key);

alter table options.monitorada
    owner to orr_master;