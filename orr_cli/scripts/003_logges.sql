
create table if not EXISTS public.logger (
	id serial4 PRIMARY KEY,
	schema_name varchar(50),
	message  text,
	created_at   timestamp with time zone default now()
);

alter table public.logger
        owner to orr_master;


GRANT SELECT, INSERT ON public.logger TO PUBLIC;
GRANT USAGE, SELECT ON SEQUENCE logger_id_seq TO PUBLIC;

