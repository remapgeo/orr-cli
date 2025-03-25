
create function refresh_summary() returns void
    language plpgsql
as
$$
DECLARE
    schema_name TEXT;
    sql_statement TEXT;
BEGIN
    -- Obtém o nome do esquema da tabela orr_metadado.inst

	FOR schema_name IN SELECT name  FROM orr_metadata.institutions LOOP

	    -- View summary
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.summary;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;

    -- Pode adicionar mais lógica aqui, se necessário
	end loop;
    -- Retorna VOID, pois a função não retorna nenhum valor
    RETURN;

END;
$$;

alter function refresh_summary() owner to orr_master;