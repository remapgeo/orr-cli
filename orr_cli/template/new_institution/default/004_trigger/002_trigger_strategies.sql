CREATE OR REPLACE FUNCTION "{{schema}}".trigger_insert_estra_rest()
RETURNS TRIGGER AS 
$$
DECLARE
    insert_sql TEXT;
    delete_est TEXT;
    now_id uuid;
begin
	
	  delete_est := 'DELETE FROM "{{schema}}".features_estra_rest 
                   WHERE uuid = $1;' ;
                  
                  
	if new.uuid is null 
	    then 
	        now_id := old.uuid;
	    else 
	        now_id := new.uuid;

 		EXECUTE delete_est using old.uuid;
	end if;

    -- Construct the DELETE statement
    delete_est := 'DELETE FROM "{{schema}}".features_estra_rest 
                   WHERE uuid = $1;' ;
        
    -- Log the DELETE statement
    RAISE NOTICE 'Deleting: %', delete_est;
    
    -- Execute the DELETE statement
    EXECUTE delete_est using now_id;

    -- Construct the INSERT statement
    insert_sql := 'INSERT INTO "{{schema}}".features_estra_rest (uuid, code_key)
                   SELECT DISTINCT ON (mt.uuid)
                          mt.uuid,
                          CASE 
                              WHEN f.met_princ IN (''mrs00'', ''mrs01'') THEN 
                                  CASE 
                                      WHEN COUNT(mt.uuid) OVER (PARTITION BY mt.uuid) > 1 OR mt.code_key = ''mrs12'' THEN ''ers02''
                                      WHEN mt.code_key IN (''mrs02'', ''mrs04'', ''mrs05'', ''mrs06'', ''mrs11'') THEN ''ers04''
                                      WHEN mt.code_key = ''mrs13'' THEN ''ers05''
                                      WHEN mt.code_key IN (''mrs14'', ''mrs07'') THEN ''ers03''
                                      WHEN mt.code_key = ''mrs10'' THEN ''ers06''
                                      ELSE ''ers00''
                                  END
                              WHEN f.met_princ = ''mrs12'' THEN ''ers02''
                              WHEN f.met_princ IN (''mrs02'', ''mrs04'', ''mrs05'', ''mrs06'', ''mrs11'') THEN ''ers04''
                              WHEN f.met_princ = ''mrs13'' THEN ''ers05''
                              WHEN f.met_princ IN (''mrs14'', ''mrs07'') THEN ''ers03''
                              WHEN f.met_princ = ''mrs10'' THEN ''ers06''
                              ELSE ''ers00''
                          END AS ers_code
                   FROM "{{schema}}".features_met_comb mt
                   JOIN "{{schema}}".features f ON mt.uuid = f.uuid WHERE  f.uuid = $1;';

    -- Log the INSERT statement
    RAISE NOTICE 'Inserting: %', insert_sql;
  
    
    -- Execute the INSERT statement
    EXECUTE insert_sql using now_id; 

    -- Return the NEW row for the trigger
    RETURN NEW; 
END;
$$ 
LANGUAGE plpgsql;

-- Criar o gatilho
CREATE TRIGGER insert_estrategies_{{schema}}
AFTER INSERT OR UPDATE or delete ON "{{schema}}".features 
FOR EACH ROW -- 
EXECUTE FUNCTION "{{schema}}".trigger_insert_estra_rest();



-- Criar o gatilho
CREATE TRIGGER insert_estrategies_met_comb_{{schema}}
AFTER INSERT OR UPDATE or delete ON "{{schema}}".features_met_comb 
FOR EACH ROW -- 
EXECUTE FUNCTION "{{schema}}".trigger_insert_estra_rest();

