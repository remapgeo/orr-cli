create table IF NOT EXISTS options.tipo_area
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint tipo_area_pk
        primary key (code_key)
);
CREATE INDEX options_tipo_area_code_key_idx ON options.tipo_area USING btree (code_key);
CREATE INDEX options_tipo_area_pt_idx ON options.tipo_area USING btree (pt);
CREATE INDEX options_tipo_area_en_idx ON options.tipo_area USING btree (en);

alter table options.tipo_area
    owner to orr_master;