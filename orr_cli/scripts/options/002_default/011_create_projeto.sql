create table IF NOT EXISTS options.projeto
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint projeto_pk
        primary key (code_key)
);
CREATE INDEX options_projeto_code_key_idx ON options.projeto USING btree (code_key);

alter table options.projeto
    owner to orr_master;