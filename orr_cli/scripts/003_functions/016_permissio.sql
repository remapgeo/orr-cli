GRANT USAGE ON SCHEMA public TO PUBLIC;


DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT n.nspname as schema,
                     p.proname as name,
                     pg_catalog.pg_get_function_identity_arguments(p.oid) as arguments
              FROM pg_catalog.pg_proc p
              LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
              WHERE n.nspname = 'public' AND p.prokind = 'f')
    LOOP
        EXECUTE 'GRANT EXECUTE ON FUNCTION ' || r.schema || '.' || r.name || '(' || r.arguments || ') TO PUBLIC;';
    END LOOP;
END $$;

DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT n.nspname as schema,
                     p.proname as name,
                     pg_catalog.pg_get_function_identity_arguments(p.oid) as arguments
              FROM pg_catalog.pg_proc p
              LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
              WHERE n.nspname = 'public' AND p.prokind = 'p')
    LOOP
        EXECUTE 'GRANT EXECUTE ON PROCEDURE ' || r.schema || '.' || r.name || '(' || r.arguments || ') TO PUBLIC;';
    END LOOP;
END $$;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO PUBLIC;

