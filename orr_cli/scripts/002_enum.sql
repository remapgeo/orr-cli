CREATE TYPE  status_enum  as ENUM ('PENDING', 'APPROVED', 'REJECTED', 'UNDER_REVIEW');


CREATE TYPE public.hidro_code AS (
	objectid int4,
	cd_macro_rh int4,
	cd_meso_rh int4,
	cd_micro_rh int);

CREATE TYPE public.region_code AS (
	objectid int4,
	cd_country int4,
	cd_regiao int4,
	cd_bioma int4,
	amaz_legal boolean,
	matopiba boolean,
	amacro boolean,
	cd_geouf int4,
	cd_geocmu int
	);

CREATE TYPE date_type AS ENUM ('dmy', 'my', 'y');

create type ob_date as (
	dt date,
	dt_type date_type
)




