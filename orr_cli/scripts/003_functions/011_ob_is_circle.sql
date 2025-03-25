/*DONE: se a função vai funcionar bem
com a MV */
/* 
COM ESSA FUNÇÃO VAI TER UM INDICE DE 1 A 0 PARA INDICAR SE É UM CIRCULO
1 É CIRCULO PERFEITO, QUANTO MENOR O VALOR, O POLÍGONO DIFERE MAIS DE UM CIRCULO
*/
CREATE FUNCTION is_circle( geometry ) RETURNS double precision AS $$
    BEGIN
        RETURN 4.0 * pi() * (ST_Area( $1 ::geography,true) / 
                     pow(ST_Perimeter( $1 ::geography,true),2.0));
    END;
$$ LANGUAGE plpgsql
