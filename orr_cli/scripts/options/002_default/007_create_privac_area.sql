create table IF NOT EXISTS options.privac_area
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint privac_area_pk
        primary key (code_key)
);
CREATE INDEX options_privac_area_code_key_idx ON options.privac_area USING btree (code_key);
CREATE INDEX options_privac_area_pt_idx ON options.privac_area USING btree (pt);
CREATE INDEX options_privac_area_en_idx ON options.privac_area USING btree (en);

alter table options.privac_area
    owner to orr_master;