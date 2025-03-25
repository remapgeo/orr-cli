create table IF NOT EXISTS options.uso_ant_ma
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint uso_ant_ma_pk
        primary key (code_key)
);

CREATE INDEX options_uso_ant_ma_code_key_idx ON options.uso_ant_ma USING btree (code_key);
CREATE INDEX options_uso_ant_ma_pt_idx ON options.uso_ant_ma USING btree (pt);
CREATE INDEX options_uso_ant_ma_en_idx ON options.uso_ant_ma USING btree (en);

alter table options.uso_ant_ma
    owner to orr_master;