CREATE OR REPLACE FUNCTION public.ob_date_format(date_input TEXT)
RETURNS ob_date AS $$
DECLARE
    br_full BOOLEAN;
    br_month_year BOOLEAN;
    br_year_month BOOLEAN;
    str_year BOOLEAN;
    en_full BOOLEAN;
    en_month_year BOOLEAN;
    day INT;
    month INT;
    year INT;
    formatted_date date;
    format_type date_type;
BEGIN
    br_full := (date_input ~ '^\d{1,2}/\d{1,2}/\d{4}$');
    br_month_year := (date_input ~ '^\d{1,2}/\d{4}$');
    br_year_month := (date_input ~ '^\d{4}/\d{1,2}$');
    str_year := (date_input ~ '^\d{4}$');
    en_full := (date_input ~ '^\d{4}-\d{1,2}-\d{1,2}$');
    en_month_year := (date_input ~ '^\d{4}-\d{1,2}$');

    IF br_full THEN
        year := CAST(SPLIT_PART(date_input, '/', 3) AS INT);
        month := CAST(SPLIT_PART(date_input, '/', 2) AS INT);
        day := CAST(SPLIT_PART(date_input, '/', 1) AS INT);
        formatted_date := MAKE_DATE(year, month, day);
        format_type := 'dmy'::date_type;
    ELSIF br_month_year THEN
        year := CAST(SPLIT_PART(date_input, '/', 2) AS INT);
        month := CAST(SPLIT_PART(date_input, '/', 1) AS INT);
        formatted_date := MAKE_DATE(year, month, 1);
        format_type := 'my'::date_type;
    ELSIF br_year_month THEN
        year := CAST(SPLIT_PART(date_input, '/', 1) AS INT);
        month := CAST(SPLIT_PART(date_input, '/', 2) AS INT);
        formatted_date := MAKE_DATE(year, month, 1);
        format_type := 'my'::date_type;
    ELSIF str_year THEN
        formatted_date := TO_TIMESTAMP(date_input, 'YYYY');
        format_type := 'y'::date_type;
    ELSIF en_full THEN
        year := CAST(SPLIT_PART(date_input, '-', 1) AS INT);
        month := CAST(SPLIT_PART(date_input, '-', 2) AS INT);
        day := CAST(SPLIT_PART(date_input, '-', 3) AS INT);
        formatted_date := MAKE_DATE(year, month, day);
        format_type := 'dmy'::date_type;
    ELSIF en_month_year THEN
        year := CAST(SPLIT_PART(date_input, '-', 1) AS INT);
        month := CAST(SPLIT_PART(date_input, '-', 2) AS INT);
        formatted_date := MAKE_DATE(year, month, 1);
        format_type := 'my'::date_type;
    ELSE
        formatted_date := NULL;
        format_type := NULL;
    END IF;

    RETURN row(formatted_date, format_type);
END;
$$ LANGUAGE plpgsql;
