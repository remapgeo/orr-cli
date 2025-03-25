create table IF NOT EXISTS options.met_comb
(
    name_key   varchar(50) not null,
    code_key   varchar(5) not null,
    pt      varchar(256) not null,
    en      varchar(256) not null,
    text_replace varchar[] default null,
    constraint met_comb_pk
        primary key (code_key)
);
CREATE INDEX options_met_comb_code_key_idx ON options.met_comb USING btree (code_key);
CREATE INDEX options_met_comb_pt_idx ON options.met_comb USING btree (pt);
CREATE INDEX options_met_comb_en_idx ON options.met_comb USING btree (code_key);


alter table options.met_comb
    owner to orr_master;
