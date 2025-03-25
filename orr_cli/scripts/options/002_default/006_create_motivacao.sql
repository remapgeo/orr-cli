create table IF NOT EXISTS options.motivacao
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint motivacao_pk
        primary key (code_key)
);
CREATE INDEX options_motivacao_code_key_idx ON options.motivacao USING btree (code_key);
CREATE INDEX options_motivacao_pt_idx ON options.motivacao USING btree (pt);
CREATE INDEX options_motivacao_en_idx ON options.motivacao USING btree (en);

alter table options.motivacao
    owner to orr_master;