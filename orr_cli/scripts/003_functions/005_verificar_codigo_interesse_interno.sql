CREATE OR REPLACE FUNCTION verificar_codigo_interesse_interno( number INT, list_interece anyarray)
RETURNS  bool AS
$$
declare
    encontrado boolean;
BEGIN
    SELECT EXISTS(SELECT 1 FROM unnest(list_interece) WHERE unnest = number) INTO encontrado;
    return encontrado;
END;
$$ LANGUAGE plpgsql;

