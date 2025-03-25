CREATE OR REPLACE FUNCTION public.ob_date_format_reverse(date_input ob_date)
RETURNS TEXT AS $$
DECLARE
    formatted_date TEXT;
BEGIN
    -- Verifica o tipo de formato e aplica o formato adequado
    IF date_input.dt_type = 'dmy' THEN
        -- Formato dia/mês/ano
        formatted_date := TO_CHAR(date_input.dt, 'DD/MM/YYYY');
    ELSIF date_input.dt_type = 'my' THEN
        -- Formato mês/ano
        formatted_date := TO_CHAR(date_input.dt, 'MM/YYYY');
    ELSIF date_input.dt_type = 'y' THEN
        -- Formato ano
        formatted_date := TO_CHAR(date_input.dt, 'YYYY');
    ELSE
        -- Se o tipo não for reconhecido, retorna NULL
        formatted_date := NULL;
    END IF;

    RETURN formatted_date;
END;
$$ LANGUAGE plpgsql;