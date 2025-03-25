create table IF NOT EXISTS options.met_princ
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint met_princ_pk
        primary key (code_key)
);

CREATE INDEX options_met_princ_code_key_idx ON options.met_princ USING btree (code_key);
CREATE INDEX options_met_princ_pt_idx ON options.met_princ USING btree (pt);
CREATE INDEX options_met_princ_en_idx ON options.met_princ USING btree (code_key);


alter table options.met_princ
    owner to orr_master;
