CREATE SCHEMA IF NOT EXISTS orr;


create materialized view orr.mv_intersec_all as
select * from calculate_area_colides_all_schemas();

alter materialized view  orr.mv_intersec_all  owner to orr_master;
