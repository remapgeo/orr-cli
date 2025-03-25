
create table IF NOT EXISTS options.categoria
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint categoria_pk
        primary key (code_key)
);
CREATE INDEX options_categoria_code_key_idx ON options.categoria USING btree (code_key);
CREATE INDEX options_categoria_pt_idx ON options.categoria USING btree (pt);

CREATE INDEX options_categoria_en_idx ON options.categoria USING btree (en);



alter table options.categoria
    owner to orr_master;