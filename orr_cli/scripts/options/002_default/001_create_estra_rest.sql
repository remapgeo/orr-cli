create table IF NOT EXISTS options.estra_rest
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint estra_rest_pk
        primary key (code_key)
);

CREATE INDEX options_estra_rest_code_key_idx ON options.estra_rest USING btree (code_key);
CREATE INDEX options_estra_rest_pt_idx ON options.estra_rest USING btree (pt);
CREATE INDEX options_estra_rest_en_idx ON options.estra_rest USING btree (en);





alter table options.estra_rest
    owner to orr_master;