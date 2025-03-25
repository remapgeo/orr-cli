create table IF NOT EXISTS options.proj_ativo
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint proj_ativo_pk
        primary key (code_key)
);
CREATE INDEX options_proj_ativo_code_key_idx ON options.proj_ativo USING btree (code_key);
CREATE INDEX options_proj_ativo_pt_idx ON options.proj_ativo USING btree (pt);
CREATE INDEX options_proj_ativo_en_idx ON options.proj_ativo USING btree (en);

alter table options.proj_ativo
    owner to orr_master;