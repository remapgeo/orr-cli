-- TODO para dar refresh em todas as MVs
CREATE OR REPLACE FUNCTION refresh_materialized_views()
RETURNS VOID AS $$
DECLARE
    schema_name TEXT;
    sql_statement TEXT;
BEGIN
    -- Obtém o nome do esquema da tabela orr_metadado.inst
    
	FOR schema_name IN SELECT name  FROM orr_metadata.institutions LOOP

	    -- Refresh das materialized views
	    -- View mv_notificacao_formato
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.mv_notificacao_formato;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;
	
	    -- View mv_notificacao_area
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.mv_notificacao_area;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;
	
	    -- View mv_intersec_intern
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.mv_intersec_intern;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;
	
	    -- View mv_features
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.mv_features;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;

    -- Pode adicionar mais lógica aqui, se necessário
	end loop;
    -- Retorna VOID, pois a função não retorna nenhum valor
    RETURN;
   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION public.refresh_intersec_intern()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    schema_name TEXT;
    sql_statement TEXT;
BEGIN
    -- Obtém o nome do esquema da tabela orr_metadado.inst
    
	FOR schema_name IN SELECT name  FROM orr_metadata.institutions LOOP

	
	    -- View mv_intersec_intern
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.mv_intersec_intern;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;
	

    -- Pode adicionar mais lógica aqui, se necessário
	end loop;
    -- Retorna VOID, pois a função não retorna nenhum valor
    RETURN;
   
END;
$function$
;


CREATE OR REPLACE FUNCTION public.refresh_notificacao_area()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    schema_name TEXT;
    sql_statement TEXT;
BEGIN
    -- Obtém o nome do esquema da tabela orr_metadado.inst
    
	FOR schema_name IN SELECT name  FROM orr_metadata.institutions LOOP

	
	    -- View mv_notificacao_area
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.mv_notificacao_area;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;
	


    -- Pode adicionar mais lógica aqui, se necessário
	end loop;
    -- Retorna VOID, pois a função não retorna nenhum valor
    RETURN;
   
END;
$function$
;


CREATE OR REPLACE FUNCTION public.refresh_features()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    schema_name TEXT;
    sql_statement TEXT;
BEGIN
    -- Obtém o nome do esquema da tabela orr_metadado.inst
    
	FOR schema_name IN SELECT name  FROM orr_metadata.institutions LOOP
	
	    -- View mv_features
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.mv_features;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;

    -- Pode adicionar mais lógica aqui, se necessário
	end loop;
    -- Retorna VOID, pois a função não retorna nenhum valor
    RETURN;
   
END;
$function$
;


CREATE OR REPLACE FUNCTION public.refresh_notificacao_formato()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    schema_name TEXT;
    sql_statement TEXT;
BEGIN
    -- Obtém o nome do esquema da tabela orr_metadado.inst
    
	FOR schema_name IN SELECT name  FROM orr_metadata.institutions LOOP
	    -- View mv_notificacao_area
	    sql_statement := 'REFRESH MATERIALIZED VIEW ' || quote_ident(schema_name) || '.mv_notificacao_formato;';
	    raise notice '%' , sql_statement;
	    EXECUTE sql_statement;

    -- Pode adicionar mais lógica aqui, se necessário
	end loop;
    -- Retorna VOID, pois a função não retorna nenhum valor
    RETURN;
   
END;
$function$
;