create table IF NOT EXISTS options.monitorada_ma
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint monitorada_ma_pk
        primary key (code_key)
);
CREATE INDEX options_monitorada_ma_code_key_idx ON options.monitorada_ma USING btree (code_key);
CREATE INDEX options_monitorada_ma_pt_idx ON options.monitorada_ma USING btree (pt);
CREATE INDEX options_monitorada_ma_en_idx ON options.monitorada_ma USING btree (en);

alter table options.monitorada_ma
    owner to orr_master;