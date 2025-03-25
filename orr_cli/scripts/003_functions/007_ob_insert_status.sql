CREATE OR REPLACE FUNCTION public.ob_insert_status(
    uuid uuid, 
    fonte_schema text, 
    save_schema text
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER -- Executa com os privilégios do proprietário
AS $function$
BEGIN
    EXECUTE format(
        'INSERT INTO %I.status_features (uuid, schema_name, status) 
         VALUES (%L, %L, ''PENDING''::status_enum) 
         ON CONFLICT (uuid, schema_name) 
         DO UPDATE SET status = EXCLUDED.status 
         WHERE %I.status_features.uuid = %L;',
        save_schema, uuid, fonte_schema, save_schema, uuid
    );
    RAISE NOTICE 'Added % in %', uuid, save_schema;
END;
$function$;

ALTER FUNCTION public.ob_insert_status(uuid, text, text) OWNER TO orr_master;