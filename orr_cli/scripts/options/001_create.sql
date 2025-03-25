create schema if not EXISTS options;
alter schema options owner to orr_master;

GRANT USAGE ON SCHEMA options TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA options GRANT SELECT ON TABLES TO PUBLIC;