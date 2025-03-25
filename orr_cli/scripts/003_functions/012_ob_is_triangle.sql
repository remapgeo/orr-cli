/*DONE: se a função vai funcionar bem
com a MV */
/* 
COM ESSA FUNÇÃO VAMOS TENTAR IDENTIFICAR 
SE TEM 3 PONTOS E SE FORMAM UM TRIANGULO
*/

CREATE OR REPLACE FUNCTION is_triangle(geom geometry)
RETURNS BOOLEAN AS $$
BEGIN
    -- Extrair os três pontos da geometria se houver exatamente três pontos
    IF ST_NumPoints(geom) = 3 THEN
        RETURN True;
    ELSE
        -- Se não houver exatamente três pontos, não é um triângulo
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;